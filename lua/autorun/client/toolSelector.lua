local PANEL = {}

function PANEL:Init()
	self:SetSize( 100, 100 )
	self:AddChoice( "None" )
	self:SetValue( "None" )
	self:SetSortItems( false )
	self.DropButton.Paint = function( panel, w, h ) return end
	self:SetContentAlignment(5)
	self:SetTextColor(Color(255,255,255,255))
	for i = 1, #TQC.Tools do
		self:AddChoice(TQC.Tools[i])
	end

	DButton.SetFont( self, "CenterPrintText" )
	surface.SetFont( "CenterPrintText" )
end

function PANEL:Paint(w, h)
	draw.RoundedBox( 4, 0, 0, w, h, Color(50,50,50,255) )
	if self:IsHovered() then
		draw.RoundedBox( 4, 0, 0, w, h, Color( 70, 70, 70, 255 ) )
	end
end

function PANEL:DoRightClick()
	self:ChooseOption( "None", 1 )
end

function PANEL:OpenMenu( pControlOpener ) --adapted from the original derma menu DComboBox. This was to change colors

	if ( pControlOpener && pControlOpener == self.TextEntry ) then
		return
	end

	-- Don't do anything if there aren't any options..
	if ( #self.Choices == 0 ) then return end

	-- If the menu still exists and hasn't been deleted
	-- then just close it and don't open a new one.
	if ( IsValid( self.Menu ) ) then
		self.Menu:Remove()
		self.Menu = nil
	end

	self.Menu = DermaMenu( false, self )

	for k, v in pairs( self.Choices ) do
		local option = self.Menu:AddOption( v, function() self:ChooseOption( v, k ) end )
		option:SetTextColor(Color(255,255,255,255))
		if ( self.ChoiceIcons[ k ] ) then
			option:SetIcon( self.ChoiceIcons[ k ] )
		end
	end

	local x, y = self:LocalToScreen( 0, self:GetTall() )

	self.Menu.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(55, 55, 55, 255))
	end
	self.Menu:SetMinimumWidth( self:GetWide() )
	self.Menu:Open( x, y, false, self )

end

function PANEL:OnCursorEntered()
	surface.PlaySound( "garrysmod/ui_hover.wav" )
	self:SetTextColor( Color(255,0,0,255) )
end

function PANEL:OnCursorExited()
	self:SetTextColor( Color(255,255,255,255) )
end


vgui.Register( "tqc_tool_selector", PANEL, "DComboBox" )