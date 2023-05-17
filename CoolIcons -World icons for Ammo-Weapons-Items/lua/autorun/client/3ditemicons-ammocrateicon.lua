hook.Add( "HUDPaint", "AmmoCrateIcon", function()

local ammooutline = Material("ammooutline.png")

local itemdistance = GetConVar("ItemIconDistance"):GetInt() // Player-Chosen distance
local OutlineEnabled = GetConVar("IconOutlines"):GetBool()
local XRayVision = GetConVar("SeeThruWalls"):GetBool() // If icons appear through walls

local sizeoficon = GetConVar("IconSize"):GetInt() // Size, as chosen by player
local outlineicon = sizeoficon + 0.75 // Outline is always slightly bigger

if GetConVar("CustomAmmoIcon"):GetInt() == 1 and !Material(GetConVar("CustomAmmoIconImage"):GetString()):IsError() then
ammoicon = Material(GetConVar("CustomAmmoIconImage"):GetString())
ammocolor = color_white // No color modification
else
ammoicon = Material("ammoicon.png")
ammocolor = Color(GetConVar("AmmoColorR"):GetInt(),GetConVar("AmmoColorG"):GetInt(),GetConVar("AmmoColorB"):GetInt(),GetConVar("AmmoColorA"):GetInt())
end

local p = LocalPlayer()

for k, v in pairs (ents.FindByClass("item_ammo_crate")) do // This should work with most custom ammo entities

if GetConVar("AmmoIcon"):GetBool() and v:IsValid() then

local ammopos = v:WorldSpaceCenter()
local distance = p:GetPos():Distance(v:WorldSpaceCenter())

local traceammo = {}
traceammo.start = v:WorldSpaceCenter()
traceammo.endpos = p:EyePos()
traceammo.mask = 1
local tracedammo = util.TraceLine(traceammo)

cam.Start3D()

if OutlineEnabled and distance < itemdistance and (XRayVision or !tracedammo.HitWorld) then
	render.SetMaterial( ammooutline )
	render.DrawSprite( ammopos, outlineicon, outlineicon, color_black )
end
if distance < itemdistance and (XRayVision or !tracedammo.HitWorld) then
	render.SetMaterial( ammoicon )
	render.DrawSprite( ammopos, sizeoficon, sizeoficon, ammocolor )
end

cam.End3D()

end
end
end)