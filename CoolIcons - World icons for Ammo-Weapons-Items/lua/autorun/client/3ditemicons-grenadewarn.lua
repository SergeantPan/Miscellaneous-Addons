hook.Add( "HUDPaint", "GrenadeWarning", function()

if GetConVar("GrenadeWarningIcon"):GetBool() then

p = LocalPlayer()

warningdistance = GetConVar("GrenadeWarningDistance"):GetInt()
XRayVision = GetConVar("SeeThruWalls"):GetBool() // If icons appear through walls
OutlineEnabled = GetConVar("IconOutlines"):GetBool()

sizeoficon = GetConVar("IconSize"):GetInt() // Size, as chosen by player
outlineicon = sizeoficon + 0.75 // Outline is always slightly bigger
grewaroutline = Material("grenadeicon.png")

if GetConVar("CustomGreWarIcon"):GetBool() and !Material(GetConVar("CustomGreWarIconImage"):GetString()):IsError() then
grewaricon = Material(GetConVar("CustomGreWarIconImage"):GetString())
grewarcolor = color_white
else
grewaricon = Material("grenadeicon.png")
grewarcolor = Color(GetConVar("GreWarColorR"):GetInt(),GetConVar("GreWarColorG"):GetInt(),GetConVar("GreWarColorB"):GetInt(),GetConVar("GreWarColorA"):GetInt())
end

for k, v in pairs(ents.FindByClass("npc_grenade_frag")) do // Grenades thrown by the enemy and player

if IsValid(v) and (v:GetNWBool("Visible", false) == true or XRayVision) then

grenadepos = v:WorldSpaceCenter()
distance = p:GetPos():Distance(v:WorldSpaceCenter())

if distance < warningdistance then
cam.Start3D()
if OutlineEnabled then
	render.SetMaterial( grewaroutline )
	render.DrawSprite( grenadepos, outlineicon, outlineicon, color_black )
end
	render.SetMaterial( grewaricon )
	render.DrawSprite( grenadepos, sizeoficon, sizeoficon, grewarcolor )
cam.End3D()
end

end
end

end
end)