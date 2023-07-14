local Modules = script:GetDescendants();
local SubModules = {};

for _, v in pairs(Modules) do
    if (not v:IsA("ModuleScript")) then continue end;
    SubModules[v.Name] = require(v);
end

return SubModules;