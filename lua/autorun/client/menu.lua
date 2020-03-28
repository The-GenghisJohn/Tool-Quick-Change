function tqc_setup()
	local frame = vgui.Create("DFrame")
	frame:SetSize(700,400)
	frame:Center()
	frame:SetTitle("Tool Quick Change Setup")
	frame:MakePopup()
	frame.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 55, 55, 55, 200 ) )
	end


	local info = vgui.Create("DLabel", frame)
	info:SetText("Right click to reset to \"None\"")
	info:SetPos(0, 75)
	info:SetSize(200, 50)
	info:Dock(TOP)
	info:SetContentAlignment( 8 )
	info:SetFont("CloseCaption_Bold")


	local startx = frame:GetWide() / 2 - 230
	local starty = frame:GetTall() / 2 - 110

	for i = 1, 8 do
		local item = vgui.Create("tqc_tool_selector", frame)
		local y = starty
		if i > 4 then y = starty + 120 end
		item:SetPos( ( (i % 4) * 120) + startx, y)

		item:SetValue(TQC.QuickItems[i])
		item.OnSelect = function( self, index, value )
			print( value .. " was selected at index " .. index )
			TQC.QuickItems[i] = value
			TQC:SaveSettings()
		end
	end

	local label = vgui.Create("DLabel", frame)
	label:SetText("Set hotkey binding:")
	label:SetSize( 200, 25 )
	label:SetPos(0, frame:GetTall() - 75)
	label:CenterHorizontal()


	local binder = vgui.Create( "DBinder", frame )
	binder:SetSize( 200, 25 )
	binder:SetPos(0, frame:GetTall() - 50)
	binder:CenterHorizontal()
	binder:SetValue(TQC.Hotkey)
	binder.Paint = function(self, w, h)
		draw.RoundedBox( 4, 0, 0, w, h, Color(55, 55, 55, 255) )
	end


	function binder:OnChange( num )
		TQC.Hotkey = num
		TQC:SaveSettings()
	end

end

function set_tqc_visible(val)
	if TQC.Showing ~= val then
		TQC.Showing = val
		gui.EnableScreenClicker(val)

		if val then
			TQC.Panel = vgui.Create("DPanel", nil)
			TQC.Panel:SetSize(ScrW(), ScrH())
			TQC.Panel.Paint = function() return end --We ain't painting anything
			build_tqc_overlay()
		else
			TQC.Panel:Clear()
			TQC.Panel:Remove()
		end
	end
end

hook.Add("HUDPaint", "Tool_Quick_Change_Hud", function()
	set_tqc_visible( input.IsKeyDown( TQC.Hotkey ) )
end)

concommand.Add("tqc", tqc_setup, false, "Set up your Tool quickchange button")