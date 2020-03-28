function build_tqc_overlay()
	local totals = 0
	local startx = ScrW() / 2 - 400
	local starty = ScrH() / 2 - 200

	for i, quickitem in ipairs(TQC.QuickItems) do
		if quickitem ~= "None" then
			local row = 0
			if i > 4 then row = 220 end
			totals = totals + 1
			local button = vgui.Create("tqc_button", TQC.Panel)
			button:SetSize(170, 170)
			button:SetPos(i % 4 * 210 + startx, starty + row)
			button:SetText(quickitem)
			button.DoClick = function()
				RunConsoleCommand( "gmod_toolmode", quickitem )
			end
		end
	end

	--Nothing is set up! Go do that dude
	if totals == 0 then
		-- Notification panel
		local NotifyPanel = vgui.Create("DNotify")
		NotifyPanel:SetPos(ScrW() / 2 - 75, ScrH() / 2 - 125)
		NotifyPanel:SetSize(150, 250)

		-- Gray background panel
		local bg = vgui.Create("DPanel", NotifyPanel)
		bg:Dock(FILL)
		bg:SetBackgroundColor(Color(64, 64, 64))

		-- Image of Dr. Kleiner (parented to background panel)
		local img = vgui.Create("DImage", bg)
		img:SetPos(11, 11)
		img:SetSize(128, 128)
		img:SetImage("entities/npc_kleiner.png")

		-- A yellow label message (parented to background panel)
		local lbl = vgui.Create("DLabel", bg)
		lbl:SetPos(11, 160)
		lbl:SetSize(128, 72)
		lbl:SetText("You need to set up tools first! Run 'tqc' in console")
		lbl:SetTextColor(Color(255, 200, 0))
		lbl:SetFont("GModNotify")
		lbl:SetWrap(true)

		-- Add the background panel to the notification
		NotifyPanel:AddItem(bg)
	end

end