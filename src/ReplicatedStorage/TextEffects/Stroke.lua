local RunService = game:GetService("RunService");

local Stroke = {};
Stroke.__index = Stroke;

function Stroke.new(uiInstance: GuiObject, size: number, color: Color3?, transparency: number?): typeof(Stroke.new)
	local self = {};

	self.UIInstance = uiInstance;
	self.Instance = Instance.new("UIStroke");
	self.Color = color or Color3.new(1, 1, 1);
	self.ColorTarget = color or Color3.new(1, 1, 1);
	self.ColorAcceleration = 1;

	self.Transparency = transparency or 0;
	self.TransparencyTarget = transparency or 0;
	self.TransparencyAcceleration = 1;

	self.Size = size;
	self.SizeTarget = size;
	self.SizeAcceleration = 1;
	self.Connection = nil;
	self.IsText = false;

	if (uiInstance:IsA("TextLabel") or uiInstance:IsA("TextBox") or uiInstance:IsA("TextButton")) then
		self.IsText = true;
	end;

	self.Instance.Parent = self.UIInstance;

	self.Connection = RunService.Heartbeat:Connect(function(dt)
		if (not self.UIInstance or self.UIInstance.Parent == nil) then
			self:Destroy();
			return;
		end;

		self.Color = self.Color:Lerp(self.ColorTarget, self.ColorAcceleration);
		self.Size = self.Size + ((self.SizeTarget - self.Size) * self.SizeAcceleration);
		self.Transparency = self.Transparency + ((self.TransparencyTarget - self.Transparency) * self.TransparencyAcceleration);

		self.Instance.Transparency = self.Transparency;
		self.Instance.Color = self.Color;
		self.Instance.Thickness = self.Size;
	end);

	return setmetatable(self, Stroke);
end

function Stroke:SetSize(size: number, acceleration: number)
	-- Accepts a Vector2 as the first argument and a number as the second argument.
	-- Values below 0 or above 1 for the acceleration argument do not make sense.
	assert(typeof(size) == "number", "Size isn't a number");
	assert(typeof(acceleration) == "number", "Acceleration isn't a number");

	self.SizeTarget = size;
	self.SizeAcceleration = math.clamp(acceleration, 0, 1);
end

function Stroke:SetTransparency(transparency: number, acceleration: number)
	-- Accepts a number as the first argument and a number as the second argument.
	-- Values below 0 or above 1 for the acceleration argument do not make sense.
	assert(typeof(transparency) == "number", "Transparency isn't a number");
	assert(typeof(acceleration) == "number", "Acceleration isn't a number");

	self.TransparencyTarget = transparency;
	self.TransparencyAcceleration = math.clamp(acceleration, 0, 1);
end

function Stroke:SetColor(color: Color3, acceleration: number)
	-- Accepts a Color3 as the first argument and a number as the second argument.
	-- Values below 0 or above 1 for the acceleration argument do not make sense.
	assert(typeof(color) == "Color3", "Color isn't a Color3");
	assert(typeof(acceleration) == "number", "Acceleration isn't a number");

	self.ColorTarget = color;
	self.ColorAcceleration = math.clamp(acceleration, 0, 1);
end

function Stroke:Destroy()
	self.Connection:Disconnect();
	self.Instance:Destroy();
	self.Instance = nil;
	setmetatable(self, nil);
end

return table.freeze(Stroke);