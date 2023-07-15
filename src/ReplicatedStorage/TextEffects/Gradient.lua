local RunService = game:GetService("RunService");

type ColorSequenceKeypoints = typeof(ColorSequence.new(Color3.new().Keypoints));
type NumberSequenceKeypoints = typeof(NumberSequence.new(0).Keypoints);

local function evalColorSequence(inputSequence: ColorSequenceKeypoints, time: number)
	local sequence = {};
	time += 1;

	for x = 0, 2 do
		for i = 1, #inputSequence do
			local datapoint = {Time = inputSequence[i].Time + x, Value = inputSequence[i].Value};
			table.insert(sequence, datapoint);
		end;
	end;

	-- Otherwise, step through each sequential pair of keypoints
	for i = 1, #sequence - 1 do
		local thisKeypoint = sequence[i];
		local nextKeypoint = sequence[i + 1];
		if time >= thisKeypoint.Time and time < nextKeypoint.Time then
			-- Calculate how far alpha lies between the points
			local alpha = (time - thisKeypoint.Time) / (nextKeypoint.Time - thisKeypoint.Time);
			-- Evaluate the real value between the points using alpha
			return Color3.new(
				(nextKeypoint.Value.R - thisKeypoint.Value.R) * alpha + thisKeypoint.Value.R,
				(nextKeypoint.Value.G - thisKeypoint.Value.G) * alpha + thisKeypoint.Value.G,
				(nextKeypoint.Value.B - thisKeypoint.Value.B) * alpha + thisKeypoint.Value.B
			);
		end;
	end;
end

local function evalNumberSequence(inputSequence: NumberSequenceKeypoints, time: number)
	local sequence = {};
	time += 1;

	for x = 0, 2 do
		for i = 1, #inputSequence do
			local datapoint = {Time = inputSequence[i].Time + x, Value = inputSequence[i].Value};
			table.insert(sequence, datapoint);
		end;
	end;

	-- Otherwise, step through each sequential pair of keypoints
	for i = 1, #sequence - 1 do
		local thisKeypoint = sequence[i];
		local nextKeypoint = sequence[i + 1];
		if (time >= thisKeypoint.Time and time < nextKeypoint.Time) then
			-- Calculate how far alpha lies between the points
			local alpha = (time - thisKeypoint.Time) / (nextKeypoint.Time - thisKeypoint.Time);
			-- Evaluate the real value between the points using alpha
			return thisKeypoint.Value + (nextKeypoint.Value - thisKeypoint.Value) * alpha;
		end;
	end;
end

local Gradient = {};
Gradient.__index = Gradient;

function Gradient.new(uiInstance: GuiObject, colorSequence: ColorSequence, transparencySequence: number | ColorSequence): typeof(Gradient.new)
	local self = {};

	self.UIInstance = uiInstance;
	self.Instance = Instance.new("UIGradient");

	self.ColorSequenceTarget = colorSequence;
	self.ColorSequence = colorSequence;
	self.TrueColorSequence = nil;
	self.ColorSequenceBlendRate = 1;

	self.TransparencySequenceTarget = nil;
	self.TransparencySequence = nil;
	self.TrueTransparencySequence = nil;
	self.TransparencySequenceBlendRate = 1;

	self.Offset = 0;
	self.OffsetTarget = nil;
	self.OffsetSpeed = 0;
	self.OffsetSpeedTarget = 0;
	self.OffsetAcceleration = 1;

	self.TransparencyOffset = 0;
	self.TransparencyOffsetTarget = nil;
	self.TransparencyOffsetSpeed = 0;
	self.TransparencyOffsetSpeedTarget = 0;
	self.TransparencyOffsetAcceleration = 1;

	self.Rotation = 0;
	self.RotationSpeed = 0;
	self.RotationSpeedTarget = 0;
	self.RotationAcceleration = 0;
	self.RotationTarget = nil;

	self.Connection = nil;
	self.IsText = false;

	if (typeof(transparencySequence) == "number") then
		self.TransparencySequenceTarget = NumberSequence.new({NumberSequenceKeypoint.new(0, transparencySequence), NumberSequenceKeypoint.new(1, transparencySequence)});
	elseif (typeof(transparencySequence) == "NumberSequence") then
		self.TransparencySequenceTarget = transparencySequence;
	else
		warn("Weird type of data?");
	end;

	self.TransparencySequence = self.TransparencySequenceTarget;

	if (uiInstance:IsA("TextLabel") or uiInstance:IsA("TextBox") or uiInstance:IsA("TextButton")) then
		self.IsText = true;
	end;

	self.Connection = RunService.Heartbeat:Connect(function(dt)
		if (not self.UIInstance or self.UIInstance.Parent == nil) then
			self:Destroy();
			return;
		end;

		if (self.ColorSequenceBlendRate == 1) then
			self.ColorSequence = self.ColorSequenceTarget;
		else
			self:EqualizeColorSequenceKeypoints();
		end;

		if (self.TransparencySequenceBlendRate == 1) then
			self.TransparencySequence = self.TransparencySequenceTarget;
		end;

		if (self.OffsetTarget) then
			self.Offset = self.Offset + (self.OffsetTarget - self.Offset) * self.OffsetAcceleration;
		else
			self.OffsetSpeed = self.OffsetSpeed + (self.OffsetSpeedTarget - self.OffsetSpeed) * self.OffsetAcceleration;
			self.Offset += self.OffsetSpeed;
		end;

		if (self.TransparencyOffsetTarget) then
			self.TransparencyOffset = self.TransparencyOffset + (self.TransparencyOffsetTarget - self.TransparencyOffset) * self.TransparencyOffsetAcceleration;
		else
			self.TransparencyOffsetSpeed = self.TransparencyOffsetSpeed + (self.TransparencyOffsetSpeedTarget - self.TransparencyOffsetSpeed) * self.TransparencyOffsetAcceleration;
			self.TransparencyOffset += self.TransparencyOffsetSpeed;
		end;

		if (self.RotationTarget) then
			self.Rotation = self.Rotation + (self.RotationTarget - self.Rotation) * self.RotationAcceleration;
		else
			self.RotationSpeed = self.RotationSpeed + (self.RotationSpeedTarget - self.RotationSpeed) * self.RotationAcceleration;
			self.Rotation += self.RotationSpeed;
		end;

		self.Instance.Rotation = self.Rotation;
		self.Instance.Color = self:CalculateTrueColorSequence();
		self.Instance.Transparency = self:CalculateTrueTransparencySequence();
	end);

	self.Instance.Parent = self.UIInstance;
	return setmetatable(self, Gradient);
end

function Gradient:SetColorSequence(sequence: ColorSequence, blendRate: number?): ColorSequence
	assert(typeof(sequence) == "ColorSequence", "Sequence argument is nil or not a ColorSequence");

	self.ColorSequenceBlendRate = blendRate or 1;
	self.ColorSequenceTarget = sequence;

	return self.ColorSequenceTarget;
end

function Gradient:SetOffset(offset: number, acceleration: number?)
	-- Accepts a number as the first argument and a number as the second argument.
	-- Values below 0 or above 1 for the acceleration argument do not make sense.
	assert(typeof(offset) == "number", "Offset isn't a number");
	assert(typeof(acceleration) == "number", "Acceleration isn't a number");

	self.OffsetTarget = offset;
	self.OffsetSpeed = 0;
	self.OffsetSpeedTarget = 0;
	self.OffsetAcceleration = math.clamp(acceleration, 0, 1);
end

function Gradient:SetOffsetSpeed(offset: number, acceleration: number?)
	-- Accepts a number as the first argument and a number as the second argument.
	-- Values below 0 or above 1 for the acceleration argument do not make sense.
	assert(typeof(offset) == "number", "Offset isn't a number");
	assert(typeof(acceleration) == "number", "Acceleration isn't a number");

	self.OffsetSpeedTarget = offset;
	self.OffsetTarget = nil;
	self.OffsetAcceleration = math.clamp(acceleration, 0, 1);
end

function Gradient:SetRotation(rotation: number, acceleration: number?)
	-- Accepts a number as the first argument and a number as the second argument.
	-- Values below 0 or above 1 for the acceleration argument do not make sense.
	assert(typeof(rotation) == "number", "Offset isn't a number");
	assert(typeof(acceleration) == "number", "Acceleration isn't a number");

	self.RotationTarget = rotation;
	self.RotationSpeed = 0;
	self.RotationSpeedTarget = 0;
	self.RotationAcceleration = math.clamp(acceleration, 0, 1);
end

function Gradient:SetRotationSpeed(rotation: number, acceleration: number?)
	-- Accepts a number as the first argument and a number as the second argument.
	-- Values below 0 or above 1 for the acceleration argument do not make sense.
	assert(typeof(rotation) == "number", "Offset isn't a number");
	assert(typeof(acceleration) == "number", "Acceleration isn't a number");

	self.RotationSpeedTarget = rotation;
	self.RotationTarget = nil;
	self.RotationAcceleration = math.clamp(acceleration, 0, 1);
end

function Gradient:SetTransparencyOffset(offset: number, acceleration: number)
	-- Accepts a number as the first argument and a number as the second argument.
	-- Values below 0 or above 1 for the acceleration argument do not make sense.
	assert(typeof(offset) == "number", "Offset isn't a number");
	assert(typeof(acceleration) == "number", "Acceleration isn't a number");

	self.TransparencyOffsetTarget = offset;
	self.TransparencyOffsetSpeed = 0;
	self.TransparencyOffsetSpeedTarget = 0;
	self.TransparencyOffsetAcceleration = math.clamp(acceleration, 0, 1);
end

function Gradient:SetTransparencyOffsetSpeed(offset: number, acceleration: number)
	-- Accepts a number as the first argument and a number as the second argument.
	-- Values below 0 or above 1 for the acceleration argument do not make sense.
	assert(typeof(offset) == "number", "Offset isn't a number");
	assert(typeof(acceleration) == "number", "Acceleration isn't a number");

	self.TransparencyOffsetSpeedTarget = offset;
	self.TransparencyOffsetTarget = nil;
	self.TransparencyOffsetAcceleration = math.clamp(acceleration, 0, 1);
end

function Gradient:SetTransparencySequence(transparency: number | NumberSequence, acceleration: number?)
	-- Accepts a number or a NumberSequence as the first argument and a number as the second argument.
	-- Values below 0 or above 1 for the acceleration argument do not make sense.
	assert(transparency, "Transparency is nil");
	assert(typeof(acceleration) == "number", "Acceleration isn't a number");

	if (typeof(transparency) == "number") then
		self.TransparencyTarget = NumberSequence.new({NumberSequenceKeypoint.new(0, transparency), NumberSequenceKeypoint.new(1, transparency)});
	elseif (typeof(transparency) == "NumberSequence") then
		self.TransparencyTarget = transparency;
	else
		warn("Weird type of data?");
	end;

	self.TransparencyAcceleration = math.clamp(acceleration, 0, 1);
end

function Gradient:EqualizeColorSequenceKeypoints()
	local keypointsA = self.ColorSequenceTarget.Keypoints;
	local keypointsB = self.ColorSequence.Keypoints;
	local newkeypoints = {};

	if (#keypointsA ~= #keypointsB) then
		for i, v in pairs(keypointsA) do
			local new = ColorSequenceKeypoint.new(v.Time, evalColorSequence(keypointsB, v.Time));
			table.insert(newkeypoints, new);
		end;
	else
		for _, v in pairs(keypointsA) do
			local sample = evalColorSequence(keypointsB, v.Time);
			local blend = sample:Lerp(v.Value, self.ColorSequenceBlendRate);
			local new = ColorSequenceKeypoint.new(v.Time, blend);
			table.insert(newkeypoints, new);
		end;
	end;

	self.ColorSequence = ColorSequence.new(newkeypoints);
end

function Gradient:EqualizeTransparencySequenceKeypoints()
	local keypointsA = self.TransparencySequenceTarget.Keypoints;
	local keypointsB = self.TransparencySequence.Keypoints;
	local newkeypoints = {};

	if (#keypointsA ~= #keypointsB) then
		for i, v in pairs(keypointsA) do
			local new = NumberSequenceKeypoint.new(v.Time, evalNumberSequence(keypointsB, v.Time));
			table.insert(newkeypoints, new);
		end;
	else
		for _, v in pairs(keypointsA) do
			local sample = evalNumberSequence(keypointsB, v.Time);
			local blend = sample:Lerp(v.Value, self.TransparencySequenceBlendRate);
			local new = NumberSequenceKeypoint.new(v.Time, blend);
			table.insert(newkeypoints, new);
		end;
	end;

	self.TransparencySequence = NumberSequence.new(newkeypoints);
end

function Gradient:CalculateTrueColorSequence()
	local temp = {};
	local lowestKeypointIndex = 5;
	local lowestTime = 100;

	for _, v in pairs(self.ColorSequence.Keypoints) do
		local newKeypoint = ColorSequenceKeypoint.new((v.Time + self.Offset) % 1, v.Value);
		if (newKeypoint.Time <= lowestTime) then
			temp[lowestKeypointIndex - 1] = newKeypoint;
			lowestKeypointIndex = lowestKeypointIndex - 1;
			lowestTime = newKeypoint.Time;
		else
			temp[#temp + 1] = newKeypoint;
		end;
	end;

	local keypoints = {};
	for i,v in pairs(temp) do
		table.insert(keypoints, v);
	end;

	table.sort(keypoints, function(a, b)
		return a.Time < b.Time;
	end);

	if keypoints[1].Time ~= 0 then
		local newPoint = ColorSequenceKeypoint.new(0, evalColorSequence(keypoints, 0));
		table.insert(keypoints, 1, newPoint);
	end;

	if keypoints[#keypoints].Time ~= 1 then
		local newPoint = ColorSequenceKeypoint.new(1, evalColorSequence(keypoints, 1));
		table.insert(keypoints, newPoint);
	end;

	self.TrueColorSequence = ColorSequence.new(keypoints);
	return self.TrueColorSequence;
end

function Gradient:CalculateTrueTransparencySequence()
	if (#self.TransparencySequenceTarget.Keypoints == 2) then
		if (self.TransparencySequenceTarget.Keypoints[1].Value == self.TransparencySequenceTarget.Keypoints[2].Value) then
			self.TrueTransparencySequence = self.TransparencySequenceTarget;
			return self.TrueTransparencySequence;
		end;
	end;

	local temp = {};
	local lowestKeypointIndex = 100;
	local lowestTime = 100;

	for _, v in pairs(self.TransparencySequence.Keypoints) do
		local newKeypoint = NumberSequenceKeypoint.new((v.Time + self.TransparencyOffset) % 1, v.Value);
		if (newKeypoint.Time <= lowestTime) then
			temp[lowestKeypointIndex - 1] = newKeypoint;
			lowestKeypointIndex = lowestKeypointIndex - 1;
			lowestTime = newKeypoint.Time;
		else
			temp[#temp + 1] = newKeypoint;
		end;
	end;

	local keypoints = {};
	for i,v in pairs(temp) do
		table.insert(keypoints, v);
	end;

	table.sort(keypoints, function(a, b)
		return a.Time < b.Time;
	end)

	if (keypoints[1].Time ~= 0) then
		local newPoint = NumberSequenceKeypoint.new(0, evalNumberSequence(keypoints, 0));
		table.insert(keypoints, 1, newPoint);
	end;

	if (keypoints[#keypoints].Time ~= 1) then
		local value = evalNumberSequence(keypoints, 1);
		local newPoint = NumberSequenceKeypoint.new(1, value);
		table.insert(keypoints, newPoint);
	end;

	self.TrueTransparencySequence = NumberSequence.new(keypoints);
	return self.TrueTransparencySequence;
end

function Gradient:Destroy()
	self.Connection:Disconnect();
	self.Instance:Destroy();
	self.Instance = nil;
	setmetatable(self, nil);
end

return table.freeze(Gradient);