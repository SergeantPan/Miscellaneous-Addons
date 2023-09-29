hook.Add( "HUDPaint", "RocketIcon", function()

if GetConVar("RocketIcon"):GetBool() then

p = LocalPlayer()

itemdistance = GetConVar("ItemIconDistance"):GetInt() // Player-Chosen distance
OutlineEnabled = GetConVar("IconOutlines"):GetBool()
XRayVision = GetConVar("SeeThruWalls"):GetBool() // If icons appear through walls

sizeoficon = GetConVar("IconSize"):GetInt() // Size, as chosen by player
outlineicon = sizeoficon + 0.75 // Outline is always slightly bigger
rocketoutline = Material("rocketoutline.png")

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

for k, v in pairs(ents.FindByClass("item_rpg_round")) do

if IsValid(v) and (v:GetNWBool("Visible", false) == true or XRayVision) then

rocketpos = v:WorldSpaceCenter()
distance = p:GetPos():Distance(v:WorldSpaceCenter())

if distance < itemdistance then
cam.Start3D()
if OutlineEnabled then
	render.SetMaterial( rocketoutline )
	render.DrawSprite( rocketpos, outlineicon, outlineicon, color_black )
end
	render.SetMaterial( rocketicon )
	render.DrawSprite( rocketpos, sizeoficon, sizeoficon, rocketcolor )
cam.End3D()
end

end

end
end
end)