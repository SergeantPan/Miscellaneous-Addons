hook.Add( "HUDPaint", "WeaponIcon", function()

local itemdistance = GetConVar("ItemIconDistance"):GetInt() // Player-Chosen distance

local XRayVision = GetConVar("SeeThruWalls"):GetBool() // If icons appear through walls

local OutlineEnabled = GetConVar("IconOutlines"):GetBool()

local sizeoficon = GetConVar("IconSize"):GetInt() // Size, as chosen by player
local outlineicon = sizeoficon + 0.75 // Outline is always slightly bigger

local weaponoutline = Material("gunicon.png")

if GetConVar("CustomWeaponIcon"):GetBool() and !Material(GetConVar("CustomWeaponIconImage"):GetString()):IsError() then
weaponicon = Material(GetConVar("CustomWeaponIconImage"):GetString())
weaponcolor = color_white // No color modification
else
weaponicon = Material("gunicon.png")
weaponcolor = Color(GetConVar("WeaponColorR"):GetInt(),GetConVar("WeaponColorG"):GetInt(),GetConVar("WeaponColorB"):GetInt(),GetConVar("WeaponColorA"):GetInt())
end

local p = LocalPlayer()

for k, v in pairs(ents.GetAll()) do

local unowned = !v:GetOwner():IsPlayer() and !v:GetOwner():IsNPC()

if GetConVar("WeaponIcon"):GetBool() and v:IsWeapon() and v:GetClass() != "weapon_frag" and unowned and v:IsValid() then

local weaponpos = v:WorldSpaceCenter()
local outlinepos = v:WorldSpaceCenter() + Vector(-0.1,0,0)
local distance = p:GetPos():Distance(v:WorldSpaceCenter())

local traceweapon = {}
traceweapon.start = v:WorldSpaceCenter()
traceweapon.endpos = p:EyePos()
traceweapon.mask = 1
local tracedweapon = util.TraceLine(traceweapon)

cam.Start3D()

if OutlineEnabled and distance < itemdistance and (XRayVision or !tracedweapon.HitWorld) then
	render.SetMaterial( weaponoutline )
	render.DrawSprite( outlinepos, outlineicon, outlineicon, color_black )
end
if distance < itemdistance and (XRayVision or !tracedweapon.HitWorld) then
	render.SetMaterial( weaponicon )
	render.DrawSprite( weaponpos, sizeoficon, sizeoficon, weaponcolor )
end

cam.End3D()

end
end
end)