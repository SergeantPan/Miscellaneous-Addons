hook.Add( "HUDPaint", "GrenadeIcon", function()

local itemdistance = GetConVar("ItemIconDistance"):GetInt() // Player-Chosen distance

local XRayVision = GetConVar("SeeThruWalls"):GetBool() // If icons appear through walls

local OutlineEnabled = GetConVar("IconOutlines"):GetBool()

local sizeoficon = GetConVar("IconSize"):GetInt() // Size, as chosen by player
local outlineicon = sizeoficon + 0.75 // Outline is always slightly bigger

local grenadeoutline = Material("grenadeicon.png")

if GetConVar("CustomGrenadeIcon"):GetBool() and !Material(GetConVar("CustomGrenadeIconImage"):GetString()):IsError() then
grenadeicon = Material(GetConVar("CustomGrenadeIconImage"):GetString())
else
grenadeicon = Material("grenadeicon.png")
end

local p = LocalPlayer()

for k, v in pairs (ents.FindByClass("weapon_frag")) do

local unowned = !v:GetOwner():IsPlayer() and !v:GetOwner():IsNPC()

if GetConVar("GrenadeIcon"):GetBool() and unowned and v:IsValid() then // Grenades

local grenadepos = v:WorldSpaceCenter()
local distance = p:GetPos():Distance(v:WorldSpaceCenter())

local tracegrenade = {}
tracegrenade.start = v:WorldSpaceCenter()
tracegrenade.endpos = p:EyePos()
tracegrenade.mask = 1
local tracedgrenade = util.TraceLine(tracegrenade)

cam.Start3D()

if OutlineEnabled and distance < itemdistance and (XRayVision or !tracedgrenade.HitWorld) then
	render.SetMaterial( grenadeoutline )
	render.DrawSprite( grenadepos, outlineicon, outlineicon, color_black )
end
if distance < itemdistance and (XRayVision or !tracedgrenade.HitWorld) then
	render.SetMaterial( grenadeicon )
	render.DrawSprite( grenadepos, sizeoficon, sizeoficon, weaponcolor )
end
cam.End3D()

end
end
end)