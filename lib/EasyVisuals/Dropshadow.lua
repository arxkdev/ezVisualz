local RunService = game:GetService("RunService");

export type Dropshadow<T...> = {
	UIInstance: GuiObject,
	Instance: GuiObject,
	IsPaused: boolean,
	Color: Color3,
	ColorTarget: Color3,
	ColorAcceleration: number,
	Transparency: number,
	TransparencyTarget: number,
	TransparencyAcceleration: number,
	Offset: Vector2,
	OffsetTarget: Vector2,
	OffsetAcceleration: number,
	Connection: RBXScriptConnection,
	IsText: boolean,

	Pause: (self: Dropshadow<T...>) -> nil,
	Resume: (self: Dropshadow<T...>) -> nil,
	SetOffset: (self: Dropshadow<T...>, offset: Vector2, acceleration: number) -> nil,
	SetTransparency: (self: Dropshadow<T...>, transparency: number, acceleration: number) -> nil,
	SetColor: (self: Dropshadow<T...>, color: Color3, acceleration: number) -> nil,
	Destroy: (self: Dropshadow<T...>) -> nil,
};

local Dropshadow = {};
Dropshadow.__index = Dropshadow;

function Dropshadow.new<T...>(uiInstance: GuiObject | UIStroke, color: Color3?, transparency: number?, offset: Vector2?): Dropshadow<T...>
	assert(uiInstance, "UIInstance not provided");
	assert(uiInstance:IsA("GuiObject") or uiInstance:IsA("UIStroke"), "UIInstance is not a GuiObject or UIStroke");
	if (color) then
		assert(typeof(color) == "Color3", "Color is not a Color3");
	end;
	if (transparency) then
		assert(typeof(transparency) == "number", "Transparency is not a number");
	end;
	if (offset) then
		assert(typeof(offset) == "Vector2", "Offset is not a Vector2");
	end;

	local self = {};

	self.UIInstance = uiInstance;
	self.Instance = uiInstance:Clone();
	self.IsPaused = false;

	self.Color = color or Color3.new();
	self.ColorTarget = color or Color3.new();
	self.ColorAcceleration = 1;
	self.Transparency = transparency or 0;
	self.TransparencyTarget = transparency or 0;
	self.TransparencyAcceleration = 1;
	self.Offset = offset or Vector2.new(-4, 4);
	self.OffsetTarget = offset or Vector2.new();
	self.OffsetAcceleration = 1;
	self.Connection = nil;
	self.IsText = false;

	self.Instance.Size = UDim2.new(1, 0, 1, 0);
	self.Instance:ClearAllChildren();

	self.Instance.Position = UDim2.new(0, self.Offset.X, 0, self.Offset.Y);

	if (uiInstance:IsA("TextLabel") or uiInstance:IsA("TextBox") or uiInstance:IsA("TextButton")) then
		self.Instance.TextColor3 = self.Color;
		self.IsText = true;
	end;

	self.Instance.Parent = self.UIInstance;

	self.Connection = RunService.Heartbeat:Connect(function(dt)
		if (self.IsPaused) then
			return;
		end;

		if (not self.UIInstance or self.UIInstance.Parent == nil) then
			self:Destroy();
			return;
		end;

		self.Color = self.Color:Lerp(self.ColorTarget, self.ColorAcceleration);
		self.Offset = self.Offset:Lerp(self.OffsetTarget, self.OffsetAcceleration);
		self.Transparency = self.Transparency + ((self.TransparencyTarget - self.Transparency) * self.TransparencyAcceleration);

		self.Instance.Position = UDim2.new(0, self.Offset.X, 0, self.Offset.Y);

		if (self.IsText) then
			self.Instance.Text = self.UIInstance.Text;
			self.Instance.TextTransparency = self.Transparency;
			self.Instance.TextColor3 = self.Color;
		end;

		self.Instance.ZIndex = self.UIInstance.ZIndex - 1;
	end);

	return setmetatable(self, Dropshadow);
end

function Dropshadow:SetOffset(offset: Vector2, acceleration: number)
	-- Accepts a Vector2 as the first argument and a number as the second argument.
	-- Values below 0 or above 1 for the acceleration argument do not make sense.
	assert(typeof(offset) == "Vector2", "Offset isn't a Vector2");
	assert(typeof(acceleration) == "number", "Acceleration isn't a number");

	self.OffsetTarget = offset;
	self.OffsetAcceleration = math.clamp(acceleration, 0, 1);
end

function Dropshadow:SetTransparency(transparency: number, acceleration: number)
	-- Accepts a number as the first argument and a number as the second argument.
	-- Values below 0 or above 1 for the acceleration argument do not make sense.
	assert(typeof(transparency) == "number", "Transparency isn't a number");
	assert(typeof(acceleration) == "number", "Acceleration isn't a number");

	self.TransparencyTarget = transparency;
	self.TransparencyAcceleration = math.clamp(acceleration, 0, 1);
end

function Dropshadow:SetColor(color: Color3, acceleration: number)
	-- Accepts a Color3 as the first argument and a number as the second argument.
	-- Values below 0 or above 1 for the acceleration argument do not make sense.
	assert(typeof(color) == "Color3", "Color isn't a Color3");
	assert(typeof(acceleration) == "number", "Acceleration isn't a number");

	self.ColorTarget = color;
	self.ColorAcceleration = math.clamp(acceleration, 0, 1);
end

function Dropshadow:Pause()
	self.IsPaused = true;
end

function Dropshadow:Resume()
	self.IsPaused = false;
end

function Dropshadow:Destroy()
	self.Connection:Disconnect();
	if (self.Instance) then
		self.Instance:Destroy();
		self.Instance = nil;
	end;
end

return table.freeze(Dropshadow);