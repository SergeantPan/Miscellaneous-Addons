hook.Add( "HUDPaint", "WeaponIcon", function()

if GetConVar("WeaponIcon"):GetBool() then

p = LocalPlayer()

itemdistance = GetConVar("ItemIconDistance"):GetInt() // Player-Chosen distance
XRayVision = GetConVar("SeeThruWalls"):GetBool() // If icons appear through walls
OutlineEnabled = GetConVar("IconOutlines"):GetBool()

sizeoficon = GetConVar("IconSize"):GetInt() // Size, as chosen by player
outlineicon = sizeoficon + 0.75 // Outline is always slightly bigger
weaponoutline = Material("gunicon.png")

if GetConVar("CustomWeaponIcon"):GetBool() and !Material(GetConVar("CustomWeaponIconImage"):GetString()):IsError() then
weaponicon = Material(GetConVar("CustomWeaponIconImage"):GetString())
weaponcolor = color_white // No color modification
else
weaponicon = Material("gunicon.png")
weaponcolor = Color(GetConVar("WeaponColorR"):GetInt(),GetConVar("WeaponColorG"):GetInt(),GetConVar("WeaponColorB"):GetInt(),GetConVar("WeaponColorA"):GetInt())
end

for k, v in pairs(ents.GetAll()) do

if v:IsWeapon() and v:GetClass() != "weapon_frag" and !v:GetOwner():IsPlayer() and !v:GetOwner():IsNPC() then

if IsValid(v) and (v:GetNWBool("Visible", false) == true or XRayVision) then

weaponpos = v:WorldSpaceCenter()
outlinepos = v:WorldSpaceCenter() + Vector(-0.1,0,0)
distance = p:GetPos():Distance(v:WorldSpaceCenter())

if distance < itemdistance then
cam.Start3D()
if OutlineEnabled then
	render.SetMaterial( weaponoutline )
	render.DrawSprite( outlinepos, outlineicon, outlineicon, color_black )
end
	render.SetMaterial( weaponicon )
	render.DrawSprite( weaponpos, sizeoficon, sizeoficon, weaponcolor )
cam.End3D()
end

end

end
end
end
end)