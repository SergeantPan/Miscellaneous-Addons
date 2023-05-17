hook.Add( "HUDPaint", "HealthChargerIcon", function()

local itemdistance = GetConVar("ItemIconDistance"):GetInt() // Player-Chosen distance

local XRayVision = GetConVar("SeeThruWalls"):GetBool() // If icons appear through walls

local OutlineEnabled = GetConVar("IconOutlines"):GetBool()

local sizeoficon = GetConVar("IconSize"):GetInt() // Size, as chosen by player
local outlineicon = sizeoficon + 0.75 // Outline is always slightly bigger

local healthoutline = Material("healthicon.png")

if GetConVar("CustomHealthIcon"):GetInt() == 1 and !Material(GetConVar("CustomHealthIconImage"):GetString()):IsError() then
healthicon = Material(GetConVar("CustomHealthIconImage"):GetString())
healthcolor = color_white // No color modification
else
healthicon = Material("healthicon.png")
healthcolor = Color(GetConVar("HealthColorR"):GetInt(),GetConVar("HealthColorG"):GetInt(),GetConVar("HealthColorB"):GetInt(),GetConVar("HealthColorA"):GetInt())
end

local p = LocalPlayer()

for k, v in pairs(ents.FindByClass("item_healthcharger")) do

if GetConVar("HealthChargerIcon"):GetBool() and v:IsValid() then

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