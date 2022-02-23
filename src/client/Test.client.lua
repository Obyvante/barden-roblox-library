local Library = require(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Library"))
-- SERVICES
local LoaderService = Library.getService("LoaderService")
local TableService = Library.getService("TableService")
local StringService = Library.getService("StringService")
local ModuleService = Library.getService("ModuleService")
local TaskService = Library.getService("TaskService")
local SignalService = Library.getService("SignalService")
local InterfaceService = Library.getService("InterfaceService")
-- TEMPLATES
local MetadataTemplate = Library.getTemplate("Metadata")