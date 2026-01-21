local function SmartAssert(condition: boolean, message: string)
	if (not condition) then
		error(message, 2);
	end;
end

return SmartAssert :: (boolean, string) -> ();
