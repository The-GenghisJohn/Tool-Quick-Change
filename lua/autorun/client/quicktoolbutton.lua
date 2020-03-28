local PANEL = {}

function PANEL:Init()

	self:SetTextColor( Color(255,255,255,255) )
	DButton.SetFont( self, "CloseCaption_Bold" )
	surface.SetFont( "CloseCaption_Bold" )
end

function PANEL:Paint( w, h )
	if self:IsHovered() then
		draw.RoundedBox( 6, 0, 0, w, h, Color(55,55,55,255) )
	else
		draw.RoundedBox( 6, 0, 0, w, h, Color(55,55,55,200) )
	end
end

function PANEL:OnCursorEntered()
	surface.PlaySound( "garrysmod/ui_hover.wav" )
	self:SetTextColor( Color(255,0,0,255) )
end

function PANEL:OnCursorExited()
	self:SetTextColor( Color(255,255,255,255) )
end

function PANEL:SetText( text )
	text = string.upper(text)
	DButton.SetText( self, text )
	surface.SetFont( self:GetFont() )
end


derma.DefineControl( "tqc_button", "Button", PANEL, "DButton" )