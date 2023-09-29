hook.Add( "HUDPaint", "GrenadeIcon", function()

if GetConVar("GrenadeIcon"):GetBool() then

p = LocalPlayer()

itemdistance = GetConVar("ItemIconDistance"):GetInt() // Player-Chosen distance
XRayVision = GetConVar("SeeThruWalls"):GetBool() // If icons appear through walls
OutlineEnabled = GetConVar("IconOutlines"):GetBool()

sizeoficon = GetConVar("IconSize"):GetInt() // Size, as chosen by player
outlineicon = sizeoficon + 0.75 // Outline is always slightly bigger
grenadeoutline = Material("grenadeicon.png")

if GetConVar("CustomGrenadeIcon"):GetBool() and !Material(GetConVar("CustomGrenadeIconImage"):GetString()):IsError() then
grenadeicon = Material(GetConVar("CustomGrenadeIconImage"):GetString())
else
grenadeicon = Material("grenadeicon.png")
end

for k, v in pairs (ents.FindByClass("weapon_frag")) do

if IsValid(v) and !v:GetOwner():IsPlayer() and !v:GetOwner():IsNPC() and (v:GetNWBool("Visible", false) == true or XRayVision) then

grenadepos = v:WorldSpaceCenter()
distance = p:GetPos():Distance(v:WorldSpaceCenter())

if distance < itemdistance then
cam.Start3D()
if OutlineEnabled then
	render.SetMaterial( grenadeoutline )
	render.DrawSprite( grenadepos, outlineicon, outlineicon, color_black )
end
	render.SetMaterial( grenadeicon )
	render.DrawSprite( grenadepos, sizeoficon, sizeoficon, weaponcolor )
cam.End3D()
end

end

end
end
end)