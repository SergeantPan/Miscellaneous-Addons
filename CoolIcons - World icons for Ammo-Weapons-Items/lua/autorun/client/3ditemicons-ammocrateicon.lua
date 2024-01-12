hook.Add( "HUDPaint", "AmmoCrateIcon", function()

if GetConVar("AmmoIcon"):GetBool() then

local p = LocalPlayer()

itemdistance = GetConVar("ItemIconDistance"):GetInt() // Player-Chosen distance
OutlineEnabled = GetConVar("IconOutlines"):GetBool()
XRayVision = GetConVar("SeeThruWalls"):GetBool() // If icons appear through walls

sizeoficon = GetConVar("IconSize"):GetInt() // Size, as chosen by player
outlineicon = sizeoficon + 0.75 // Outline is always slightly bigger
ammooutline = Material("ammooutline.png")

if GetConVar("CustomAmmoIcon"):GetInt() == 1 and !Material(GetConVar("CustomAmmoIconImage"):GetString()):IsError() then
ammoicon = Material(GetConVar("CustomAmmoIconImage"):GetString())
ammocolor = color_white // No color modification
else
ammoicon = Material("ammoicon.png")
ammocolor = Color(GetConVar("AmmoColorR"):GetInt(),GetConVar("AmmoColorG"):GetInt(),GetConVar("AmmoColorB"):GetInt(),GetConVar("AmmoColorA"):GetInt())
end

for k, v in pairs (ents.FindByClass("item_ammo_crate")) do

if IsValid(v) and (v:GetNWBool("Visible", false) == true or XRayVision) then

ammopos = v:WorldSpaceCenter()
distance = p:GetPos():Distance(v:GetPos())

if distance < itemdistance then
cam.Start3D()
if OutlineEnabled then
	render.SetMaterial( ammooutline )
	render.DrawSprite( ammopos, outlineicon, outlineicon, color_black )
end
	render.SetMaterial( ammoicon )
	render.DrawSprite( ammopos, sizeoficon, sizeoficon, ammocolor )
cam.End3D()
end

end

end
end
end)