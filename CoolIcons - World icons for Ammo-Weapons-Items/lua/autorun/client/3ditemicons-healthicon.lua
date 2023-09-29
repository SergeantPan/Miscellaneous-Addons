hook.Add( "HUDPaint", "HealthIcon", function()

if GetConVar("HealthIcon"):GetBool() then

p = LocalPlayer()

itemdistance = GetConVar("ItemIconDistance"):GetInt() // Player-Chosen distance
XRayVision = GetConVar("SeeThruWalls"):GetBool() // If icons appear through walls
OutlineEnabled = GetConVar("IconOutlines"):GetBool()

sizeoficon = GetConVar("IconSize"):GetInt() // Size, as chosen by player
outlineicon = sizeoficon + 0.75 // Outline is always slightly bigger
healthoutline = Material("healthicon.png")

if GetConVar("CustomHealthIcon"):GetInt() == 1 and !Material(GetConVar("CustomHealthIconImage"):GetString()):IsError() then
healthicon = Material(GetConVar("CustomHealthIconImage"):GetString())
healthcolor = color_white // No color modification
else
healthicon = Material("healthicon.png")
healthcolor = Color(GetConVar("HealthColorR"):GetInt(),GetConVar("HealthColorG"):GetInt(),GetConVar("HealthColorB"):GetInt(),GetConVar("HealthColorA"):GetInt())
end

for k, v in pairs(ents.FindByClass("*health*")) do

if IsValid(v) and v:GetClass() != "item_healthcharger" and (v:GetNWBool("Visible", false) == true or XRayVision) then

healthpos = v:WorldSpaceCenter()
distance = p:GetPos():Distance(v:WorldSpaceCenter())

if distance < itemdistance then
cam.Start3D()
if OutlineEnabled then
	render.SetMaterial( healthoutline )
	render.DrawSprite( healthpos, outlineicon, outlineicon, color_black )
end
	render.SetMaterial( healthicon )
	render.DrawSprite( healthpos, sizeoficon, sizeoficon, healthcolor )
cam.End3D()
end

end

end
end
end)