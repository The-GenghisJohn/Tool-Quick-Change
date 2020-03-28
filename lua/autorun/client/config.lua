TQC = {}
TQC.Hotkey = 0
TQC.Showing = false
TQC.Panel = nil
TQC.Tools = {}
TQC.QuickItems = {"None", "None", "None", "None", "None", "None", "None", "None"}
function SetupTQCToolsTable()
	MsgC(Color(255,255,0), "[Tool Quick Change] -> ", Color(255,255,255), tostring("Loading Tools") .. "\n")
	local tools = spawnmenu.GetTools()
	for Name, ToolTable in pairs( tools ) do
		local inTable = table.Copy( ToolTable.Items )
		for k, v in pairs( inTable ) do
			if ( istable( v ) ) then
				for i, tool in ipairs(v) do
					if tool.Command ~= "" then
						MsgC(Color(0,255,0), "[Tool Quick Change] -> ", Color(255,255,255), tostring("Added Tool " ..  tool.ItemName) .. "\n")
						table.insert(TQC.Tools, tool.ItemName)
					end
				end
			end
		end
	end
	TQC:LoadSetting()
end

function TQC:SaveSettings()
	local settings = {}
	settings.Hotkey = tostring(self.Hotkey)
	settings.Items = self.QuickItems
	print(util.TableToJSON( settings, true ))
	if !file.IsDir("ToolQuickChange.txt", "DATA") then file.CreateDir("ToolQuickChange") end
	file.Write( "ToolQuickChange/settings.json", util.TableToJSON( settings, true ) )
end

function TQC:LoadSetting()
	if file.Exists("ToolQuickChange/settings.json", "DATA") then
		MsgC(Color(0,255,0), "[Tool Quick Change] -> ", Color(255,255,255), "Loading saved settings" .. "\n")
		local json = file.Read( "ToolQuickChange/settings.json", "DATA" )
		local loadedSettings = util.JSONToTable(json)
		self.Hotkey = tonumber(loadedSettings.Hotkey)
		self.QuickItems = loadedSettings.Items
	else
		MsgC(Color(255,255,0), "[Tool Quick Change] -> ", Color(255,255,255), "No saved settings found" .. "\n")
	end
end

hook.Add("SpawnMenuCreated", "QTCToolInit", SetupTQCToolsTable)

if CLIENT then
	MsgC(Color(255,255,0), "[Tool Quick Change] -> ", Color(255,255,255), tostring("Loaded") .. "\n")
end