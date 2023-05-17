hook.Add( "HUDPaint", "ArmorChargerIcon", function()

local itemdistance = GetConVar("ItemIconDistance"):GetInt() // Player-Chosen distance

local OutlineEnabled = GetConVar("IconOutlines"):GetBool()

local XRayVision = GetConVar("SeeThruWalls"):GetBool() // If icons appear through walls

local sizeoficon = GetConVar("IconSize"):GetInt() // Size, as chosen by player
local outlineicon = sizeoficon + 0.75 // Outline is always slightly bigger

local p = LocalPlayer()

local armoroutline = Material("armoroutline.png")

if GetConVar("CustomArmorIcon"):GetInt() == 1 and !Material(GetConVar("CustomArmorIconImage"):GetString()):IsError() then
armoricon = Material(GetConVar("CustomArmorIconImage"):GetString())
armorcolor = color_white // No color modification
else
armoricon = Material("armoricon.png")
armorcolor = Color(GetConVar("ArmorColorR"):GetInt(),GetConVar("ArmorColorG"):GetInt(),GetConVar("ArmorColorB"):GetInt(),GetConVar("ArmorColorA"):GetInt())
end

for k, v in pairs (ents.FindByClass("item_suitcharger")) do

if GetConVar("ArmorIcon"):GetBool() and v:IsValid() then

local armorpos = v:WorldSpaceCenter()
local distance = p:GetPos():Distance(v:WorldSpaceCenter())

local tracearmor = {}
tracearmor.start = v:WorldSpaceCenter()
tracearmor.endpos = p:EyePos()
tracearmor.mask = 1
local tracedarmor = util.TraceLine(tracearmor)

cam.Start3D()

if OutlineEnabled and distance < itemdistance and (XRayVision or !tracedarmor.HitWorld) then
	render.SetMaterial( armoroutline )
	render.DrawSprite( armorpos, outlineicon, outlineicon, color_black )
end
if distance < itemdistance and (XRayVision or !tracedarmor.HitWorld) then
	render.SetMaterial( armoricon )
	render.DrawSprite( armorpos, sizeoficon, sizeoficon, armorcolor )
end
cam.End3D()

end
end
end)