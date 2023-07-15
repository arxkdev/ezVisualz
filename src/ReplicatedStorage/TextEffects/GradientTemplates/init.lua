local Modules = script:GetDescendants();
local SubModules = {};

for _, module in Modules do
    if (not module:IsA("ModuleScript")) then continue end;
    SubModules[module.Name] = module(module);
end

return SubModules;