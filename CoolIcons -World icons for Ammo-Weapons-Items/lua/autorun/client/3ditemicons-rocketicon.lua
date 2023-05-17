hook.Add( "HUDPaint", "RocketIcon", function()

local itemdistance = GetConVar("ItemIconDistance"):GetInt() // Player-Chosen distance

local OutlineEnabled = GetConVar("IconOutlines"):GetBool()

local XRayVision = GetConVar("SeeThruWalls"):GetBool() // If icons appear through walls

local sizeoficon = GetConVar("IconSize"):GetInt() // Size, as chosen by player
local outlineicon = sizeoficon + 0.75 // Outline is always slightly bigger

local p = LocalPlayer()

local rocketoutline = Material("rocketoutline.png")

if GetConVar("CustomRocketIcon"):GetInt() == 1 and !Material(GetConVar("CustomRocketIconImage"):GetString()):IsError() then
rocketicon = Material(GetConVar("CustomRocketIconImage"):GetString())
rocketcolor = color_white // No color modification
else
rocketicon = Material("rocketicon.png")
rocketcolor = Color(GetConVar("RocketColorR"):GetInt(),GetConVar("RocketColorG"):GetInt(),GetConVar("RocketColorB"):GetInt(),GetConVar("RocketColorA"):GetInt())
end

if GetConVar("CustomRocketIconImage"):GetString() == "rocketalticon.png" or GetConVar("CustomRocketIcon"):GetInt() == 0 then
sizeoficon = sizeoficon + 8
outlineicon = outlineicon + 9
end // The icon becomes too small, so we just do this to make it bigger

for k, v in pairs (ents.FindByClass("item_rpg_round")) do

if GetConVar("RocketIcon"):GetBool() and v:IsValid() then

local rocketpos = v:WorldSpaceCenter()
local distance = p:GetPos():Distance(v:WorldSpaceCenter())

local tracerocket = {}
tracerocket.start = v:WorldSpaceCenter()
tracerocket.endpos = p:EyePos()
tracerocket.mask = 1
local tracedrocket = util.TraceLine(tracerocket)

cam.Start3D()

if OutlineEnabled and distance < itemdistance and (XRayVision or !tracedrocket.HitWorld) then
	render.SetMaterial( rocketoutline )
	render.DrawSprite( rocketpos, outlineicon, outlineicon, color_black )
end
if distance < itemdistance and (XRayVision or !tracedrocket.HitWorld) then
	render.SetMaterial( rocketicon )
	render.DrawSprite( rocketpos, sizeoficon, sizeoficon, rocketcolor )
end
cam.End3D()

end
end
end)