hook.Add( "HUDPaint", "GrenadeWarning", function()

local warningdistance = GetConVar("GrenadeWarningDistance"):GetInt()

local XRayVision = GetConVar("SeeThruWalls"):GetBool() // If icons appear through walls

local OutlineEnabled = GetConVar("IconOutlines"):GetBool()

local sizeoficon = GetConVar("IconSize"):GetInt() // Size, as chosen by player
local outlineicon = sizeoficon + 0.75 // Outline is always slightly bigger

local p = LocalPlayer()

local grewaroutline = Material("grenadeicon.png")

if GetConVar("CustomGreWarIcon"):GetBool() and !Material(GetConVar("CustomGreWarIconImage"):GetString()):IsError() then
grewaricon = Material(GetConVar("CustomGreWarIconImage"):GetString())
grewarcolor = color_white
else
grewaricon = Material("grenadeicon.png")
grewarcolor = Color(GetConVar("GreWarColorR"):GetInt(),GetConVar("GreWarColorG"):GetInt(),GetConVar("GreWarColorB"):GetInt(),GetConVar("GreWarColorA"):GetInt())
end

for k, v in pairs (ents.FindByClass("npc_grenade_frag")) do // Grenades thrown by the enemy and player

if GetConVar("GrenadeWarningIcon"):GetBool() and v:IsValid() then

local grenadepos = v:WorldSpaceCenter()
local distance = p:GetPos():Distance(v:WorldSpaceCenter())

local tracegrenadewarn = {}
tracegrenadewarn.start = v:WorldSpaceCenter()
tracegrenadewarn.endpos = p:EyePos()
tracegrenadewarn.mask = 1
local tracedgrenadewarn = util.TraceLine(tracegrenadewarn)

cam.Start3D()

if OutlineEnabled and distance < warningdistance and (XRayVision or !tracedgrenadewarn.HitWorld) then
	render.SetMaterial( grewaroutline )
	render.DrawSprite( grenadepos, outlineicon, outlineicon, color_black )
end
if distance < warningdistance and (XRayVision or !tracedgrenadewarn.HitWorld) then // If the grenade is closer than the players chosen value, make the icon
	render.SetMaterial( grewaricon )
	render.DrawSprite( grenadepos, sizeoficon, sizeoficon, grewarcolor )
end
cam.End3D()
end
end
end)