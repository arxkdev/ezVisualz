local RunService = game:GetService("RunService");

local Dropshadow = {};
local Dropshadow_mt = {__index = Dropshadow};

function Dropshadow.new(UIInstance: GuiObject, color: Color3, transparency: number, offset: Vector2): typeof(Dropshadow.new)
	local self = {};

	self.UIInstance = UIInstance;
	self.Instance = UIInstance:Clone();
	self.Color = color or Color3.new();
	self.ColorTarget = color or Color3.new();
	self.ColorAcceleration = 1;
	self.Transparency = transparency or 0;
	self.TransparencyTarget = transparency or 0;
	self.TransparencyAcceleration = 1;
	self.Offset = offset or Vector2.new();
	self.OffsetTarget = offset or Vector2.new();
	self.OffsetAcceleration = 1;
	self.Connection = nil;
	self.IsText = false;

	self.Instance.Size = UDim2.new(1, 0, 1, 0);
	self.Instance:ClearAllChildren();

	self.Instance.TextColor3 = self.Color;
	self.Instance.Position = UDim2.new(0, self.Offset.X, 0, self.Offset.Y);

	if (UIInstance:IsA("TextLabel") or UIInstance:IsA("TextBox") or UIInstance:IsA("TextButton")) then
		self.IsText = true;
	end;

	setmetatable(self, Dropshadow_mt);
	self.Instance.Parent = self.UIInstance;

	self.Connection = RunService.RenderStepped:Connect(function(dt)
		if (not self.UIInstance or self.UIInstance.Parent == nil) then
			self:Destroy();
			return;
		end;

		self.Color = self.Color:Lerp(self.ColorTarget, self.ColorAcceleration);
		self.Offset = self.Offset:Lerp(self.OffsetTarget, self.OffsetAcceleration);
		self.Transparency = self.Transparency + ((self.TransparencyTarget - self.Transparency) * self.TransparencyAcceleration);

		self.Instance.TextTransparency = self.Transparency;
		self.Instance.TextColor3 = self.Color;
		self.Instance.Position = UDim2.new(0, self.Offset.X, 0, self.Offset.Y);

		if (self.IsText) then
			self.Instance.Text = self.UIInstance.Text;
		end;

		self.Instance.ZIndex = self.UIInstance.ZIndex - 1;
	end);

	return self;
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

function Dropshadow:Destroy()
	self.Connection:Disconnect();
	self.Instance:Destroy();

	self = nil;
end

return Dropshadow;