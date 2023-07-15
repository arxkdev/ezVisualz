local Modules = script:GetDescendants();
local SubModules = {};

for _, module in Modules do
    if (not v:IsA("ModuleScript")) then continue end;
    SubModules[v.Name] = module(v);
end

return SubModules;