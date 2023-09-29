hook.Add( "HUDPaint", "ArcCWArmorIcon", function() // VManip armor plates support

if GetConVar("ArmorIcon"):GetBool() then

p = LocalPlayer()

itemdistance = GetConVar("ItemIconDistance"):GetInt() // Player-Chosen distance
OutlineEnabled = GetConVar("IconOutlines"):GetBool()
XRayVision = GetConVar("SeeThruWalls"):GetBool() // If icons appear through walls

sizeoficon = GetConVar("IconSize"):GetInt() // Size, as chosen by player
outlineicon = sizeoficon + 0.75 // Outline is always slightly bigger
armoroutline = Material("armoroutline.png")

if GetConVar("CustomArmorIcon"):GetInt() == 1 and !Material(GetConVar("CustomArmorIconImage"):GetString()):IsError() then
armoricon = Material(GetConVar("CustomArmorIconImage"):GetString())
armorcolor = color_white // No color modification
else
armoricon = Material("armoricon.png")
armorcolor = Color(GetConVar("ArmorColorR"):GetInt(),GetConVar("ArmorColorG"):GetInt(),GetConVar("ArmorColorB"):GetInt(),GetConVar("ArmorColorA"):GetInt())
end

for k, v in pairs(ents.FindByClass("armorplate_pickup")) do

if IsValid(v) and (v:GetNWBool("Visible", false) == true or XRayVision) then

armorpos = v:WorldSpaceCenter()
distance = p:GetPos():Distance(v:WorldSpaceCenter())

if distance < itemdistance then
cam.Start3D()
if OutlineEnabled then
	render.SetMaterial( armoroutline )
	render.DrawSprite( armorpos, outlineicon, outlineicon, color_black )
end
	render.SetMaterial( armoricon )
	render.DrawSprite( armorpos, sizeoficon, sizeoficon, armorcolor )
cam.End3D()
end

end

end
end
end)

hook.Add( "HUDPaint", "ArcCWHealthIcon", function() // Combat Stims support

if GetConVar("HealthIcon"):GetBool() then

p = LocalPlayer()

itemdistance = GetConVar("ItemIconDistance"):GetInt() // Player-Chosen distance
OutlineEnabled = GetConVar("IconOutlines"):GetBool()
XRayVision = GetConVar("SeeThruWalls"):GetBool() // If icons appear through walls

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

for k, v in pairs(ents.FindByClass("arc_medshot_*")) do

if IsValid(v) and (v:GetNWBool("Visible", false) == true or XRayVision) then

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