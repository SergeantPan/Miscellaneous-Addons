hook.Add( "HUDPaint", "ArcCWArmorIcon", function() // VManip armor plates support

local itemdistance = GetConVar("ItemIconDistance"):GetInt() // Player-Chosen distance

local OutlineEnabled = GetConVar("IconOutlines"):GetBool()

local XRayVision = GetConVar("SeeThruWalls"):GetBool() // If icons appear through walls

local sizeoficon = GetConVar("IconSize"):GetInt() // Size, as chosen by player
local outlineicon = sizeoficon + 0.75 // Outline is always slightly bigger

local armoroutline = Material("armoroutline.png")

if GetConVar("CustomArmorIcon"):GetInt() == 1 and !Material(GetConVar("CustomArmorIconImage"):GetString()):IsError() then
armoricon = Material(GetConVar("CustomArmorIconImage"):GetString())
armorcolor = color_white // No color modification
else
armoricon = Material("armoricon.png")
armorcolor = Color(GetConVar("ArmorColorR"):GetInt(),GetConVar("ArmorColorG"):GetInt(),GetConVar("ArmorColorB"):GetInt(),GetConVar("ArmorColorA"):GetInt())
end

local p = LocalPlayer()

for k, v in pairs (ents.FindByClass("armorplate_pickup")) do // This should work with most custom ammo entities

if GetConVar("ArmorIcon"):GetBool() and v:IsValid() then // ArcCW at the very least

local tracearmor = {}
tracearmor.start = v:WorldSpaceCenter()
tracearmor.endpos = p:EyePos()
tracearmor.mask = 1
local tracedarmor = util.TraceLine(tracearmor)

local armorpos = v:WorldSpaceCenter()
local distance = p:GetPos():Distance(v:WorldSpaceCenter())

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

hook.Add( "HUDPaint", "ArcCWHealthIcon", function() // Combat Stims support

local p = LocalPlayer()

local healthoutline = Material("healthicon.png")
local healthcolor = {}

if GetConVar("CustomHealthIcon"):GetInt() == 1 and !Material(GetConVar("CustomHealthIconImage"):GetString()):IsError() then
healthicon = Material(GetConVar("CustomHealthIconImage"):GetString())
healthcolor = color_white // No color modification
else
healthicon = Material("healthicon.png")
healthcolor = Color(GetConVar("HealthColorR"):GetInt(),GetConVar("HealthColorG"):GetInt(),GetConVar("HealthColorB"):GetInt(),GetConVar("HealthColorA"):GetInt())
end

for k, v in pairs (ents.FindByClass("arc_medshot_*")) do

if GetConVar("HealthIcon"):GetBool() and v:IsValid() then // Should get both vial and kit

local healthpos = v:WorldSpaceCenter()
local distance = p:GetPos():Distance(v:WorldSpaceCenter())

local tracehealth = {}
tracehealth.start = v:WorldSpaceCenter()
tracehealth.endpos = p:EyePos()
tracehealth.mask = 1
local tracedhealth = util.TraceLine(tracehealth)

cam.Start3D()

if OutlineEnabled and distance < itemdistance and (XRayVision or !tracedhealth.HitWorld) then
	render.SetMaterial( healthoutline )
	render.DrawSprite( healthpos, outlineicon, outlineicon, color_black )
end
if distance < itemdistance and (XRayVision or !tracedhealth.HitWorld) then
	render.SetMaterial( healthicon )
	render.DrawSprite( healthpos, sizeoficon, sizeoficon, healthcolor )
end

cam.End3D()

end
end
end)