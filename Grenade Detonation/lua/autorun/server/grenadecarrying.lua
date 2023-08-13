hook.Add( "ScaleNPCDamage", "ShootableCarriedGrenades", function( npc, hitgroup, dmginfo )

if GetConVar("GrenadeCarryHitbox"):GetInt() == 1 then
HitboxGroup = {2, 3}
elseif GetConVar("GrenadeCarryHitbox"):GetInt() == 2 then
HitboxGroup = {2}
elseif GetConVar("GrenadeCarryHitbox"):GetInt() == 3 then
HitboxGroup = {3}
end

if GetConVar("GrenadeCarryBrokenHitgroups"):GetBool() and dmginfo:IsBulletDamage() then
table.insert(HitboxGroup, 0)
else
table.RemoveByValue(HitboxGroup, 0)
end

if GetConVar("GrenadeCarryEnabled"):GetBool() and GetConVar("GrenadeCarryHitbox"):GetInt() != 0 then

if IsValid(npc) and npc:IsNPC() and npc:GetClass() == "npc_combine_s" then

if GetConVar("GrenadeCarryNoElite"):GetBool() and npc:GetModel() == "models/combine_super_soldier.mdl" then return end

if table.HasValue(HitboxGroup, hitgroup) and GetConVar("GrenadeCarryChance"):GetInt() > math.Rand(1, 100) and npc:GetNWBool("HasDroppedGrenade", false) == false then

if npc:GetNWBool("HasDroppedGrenade", false) == false and GetConVar("GrenadeCarryNoDupes"):GetBool() then
npc:SetNWBool("HasDroppedGrenade", true)
DisableNades(npc)
end

npc:EmitSound("physics/metal/metal_sheet_impact_bullet1.wav")

local LiveGrenade = ents.Create( "npc_grenade_frag" )

LiveGrenade:SetPos( npc:WorldSpaceCenter() - (npc:GetForward() * 15) )
LiveGrenade:SetCollisionGroup(9)
LiveGrenade:SetOwner(dmginfo:GetAttacker())
LiveGrenade:Spawn()
LiveGrenade:GetPhysicsObject():SetVelocity(Vector(math.Rand(-250,250),math.Rand(-250,250),25))
LiveGrenade:Fire("SetTimer", 3, 0)

end
end
end
end)

util.AddNetworkString("HideGrenade")

hook.Add( "PlayerTick", "ActualGrenadesPly", function(ply)

for _,Gren in pairs(ents.FindByClass("prop_physics")) do
if Gren:GetNoDraw() == false and Gren:GetName() == "CarriedGrenade" and Gren:GetOwner():IsPlayer() and Gren:GetOwner() == ply then
net.Start("HideGrenade")
net.WriteEntity(Gren)
net.Send(ply)
end
if Gren:GetName() == "CarriedGrenade" and Gren:GetOwner():IsPlayer() and Gren:GetOwner() != ply then
if !IsValid(Gren:GetOwner()) or Gren:GetOwner():GetAmmoCount(10) == 0 or (Gren:GetOwner():GetActiveWeapon():IsWeapon() and Gren:GetOwner():GetActiveWeapon():GetClass() == "weapon_frag" and Gren:GetOwner():GetAmmoCount(10) < 2) then
Gren:SetNoDraw(true)
else
Gren:SetNoDraw(false)
end
if !GetConVar("GrenadeCarryPhysicalPly"):GetBool() then
Gren:Remove()
Gren:GetOwner():SetNWBool("CarryingGrenade", false)
end
end

if GetConVar("GrenadeCarryPhysicalPly"):GetBool() then

if !IsValid(ply) or !ply:Alive() then return end
Setup = ply:WorldSpaceCenter() - ply:GetForward()

if GetConVar("GrenadeCarrySidePlayer"):GetInt() == 1 then
PlyGrenadePos = Setup + ply:GetRight() * 8
else
PlyGrenadePos = Setup - ply:GetRight() * 8
end

if ply:GetAmmoCount(10) > 0 and ply:GetNWBool("CarryingGrenade", false) == false then
ActualGrenade = ents.Create("prop_physics")
ActualGrenade:SetMoveType(MOVETYPE_NONE)
ActualGrenade:SetModel("models/Items/grenadeAmmo.mdl")
ActualGrenade:FollowBone(ply, 1)
ActualGrenade:SetPos(PlyGrenadePos)
ActualGrenade:SetAngles(ply:GetAngles() + Angle(90,0,0))
ActualGrenade:SetCollisionGroup(1)
ActualGrenade:SetName("CarriedGrenade")
ActualGrenade:Spawn()
ActualGrenade:SetOwner(ply)
ply:SetNWBool("CarryingGrenade", true)
end

end

end

end)

hook.Add( "OnEntityCreated", "ActualGrenades", function(entity)

local ModelBlacklist = string.Split(GetConVar("GrenadeCarryPhysicalModelBlacklist"):GetString(), ", ")
local GrenAngNPC = GetConVar("GrenadeCarryPhysicalAngleNPC"):GetInt()

if entity:IsNPC() and entity:GetClass() == "npc_combine_s" then

if GetConVar("GrenadeCarryPhysical"):GetBool() then

timer.Simple(0.5, function()
if !IsValid(entity) then return end

if GetConVar("GrenadeCarryNoElite"):GetBool() and entity:GetModel() == "models/combine_super_soldier.mdl" then return end
if table.HasValue(ModelBlacklist, entity:GetModel()) then return end

Setup = entity:WorldSpaceCenter() - entity:GetForward()

if GetConVar("GrenadeCarrySide"):GetInt() == 1 then
GrenadePos = Setup + entity:GetRight() * 9
else
GrenadePos = Setup - entity:GetRight() * 9
end

ActualGrenade = ents.Create("prop_physics")
ActualGrenade:SetMoveType(MOVETYPE_NONE)
ActualGrenade:SetModel("models/Items/grenadeAmmo.mdl")
ActualGrenade:FollowBone(entity, 1)
ActualGrenade:SetPos(GrenadePos)
ActualGrenade:SetAngles(entity:GetAngles() + Angle(GrenAngNPC,0,0))
ActualGrenade:SetCollisionGroup(1)
ActualGrenade:SetName("CarriedGrenade")
ActualGrenade:SetOwner(entity)
ActualGrenade:Spawn()
end)
end

end

end)

hook.Add( "ScalePlayerDamage", "ShootableCarriedGrenades", function( ply, hitgroup, dmginfo )

if GetConVar("GrenadeCarryPlayerHitbox"):GetInt() == 0 then
HitboxGroup = {}
elseif GetConVar("GrenadeCarryPlayerHitbox"):GetInt() == 1 then
HitboxGroup = {2, 3}
elseif GetConVar("GrenadeCarryPlayerHitbox"):GetInt() == 2 then
HitboxGroup = {2}
elseif GetConVar("GrenadeCarryPlayerHitbox"):GetInt() == 3 then
HitboxGroup = {3}
end

if GetConVar("GrenadeCarryBrokenHitgroupsPlayer"):GetBool() and dmginfo:IsBulletDamage() then
table.insert(HitboxGroup, 0)
else
table.RemoveByValue(HitboxGroup, 0)
end

if GetConVar("GrenadeCarryPlayer"):GetBool() and GetConVar("GrenadeCarryPlayerHeld"):GetBool() and ply:GetActiveWeapon():IsWeapon() and ply:GetActiveWeapon():GetClass() == "weapon_frag" and hitgroup == 5 and GetConVar("GrenadeCarryPlayerChance"):GetInt() > math.Rand(1, 100) and ply:GetAmmoCount(10) > 0 then

ply:EmitSound("physics/metal/metal_sheet_impact_bullet2.wav")

local LiveGrenade = ents.Create( "npc_grenade_frag" )

LiveGrenade:SetPos( ply:GetBonePosition(ply:LookupBone("ValveBiped.Bip01_R_Hand")) )
LiveGrenade:SetCollisionGroup(9)
LiveGrenade:SetOwner(dmginfo:GetAttacker())
LiveGrenade:Spawn()
LiveGrenade:GetPhysicsObject():SetVelocity(Vector(math.Rand(-250,250),math.Rand(-250,250),25))
LiveGrenade:Fire("SetTimer", 3, 0)

if GetConVar("GrenadeCarryRemoveAmmo"):GetBool() then
ply:RemoveAmmo(1, 10)
end

end

if GetConVar("GrenadeCarryPlayer"):GetBool() and GetConVar("GrenadeCarryPlayerHitbox"):GetInt() != 0 then

if IsValid(ply) and ply:IsPlayer() then

if table.HasValue(HitboxGroup, hitgroup) and GetConVar("GrenadeCarryPlayerChance"):GetInt() > math.Rand(1, 100) and ply:HasWeapon("weapon_frag") and ((GetConVar("GrenadeCarryRequireAmmo"):GetBool() and ply:GetAmmoCount(10) > 0) or !GetConVar("GrenadeCarryRequireAmmo"):GetBool()) then

if GetConVar("GrenadeCarryRemoveAmmo"):GetBool() then
ply:RemoveAmmo(1, 10)
end

ply:EmitSound("physics/metal/metal_sheet_impact_bullet2.wav")

local LiveGrenade = ents.Create( "npc_grenade_frag" )

LiveGrenade:SetPos( ply:WorldSpaceCenter() - (ply:GetForward() * 15) )
LiveGrenade:SetCollisionGroup(9)
LiveGrenade:SetOwner(dmginfo:GetAttacker())
LiveGrenade:Spawn()
LiveGrenade:GetPhysicsObject():SetVelocity(Vector(math.Rand(-250,250),math.Rand(-250,250),25))
LiveGrenade:Fire("SetTimer", 3, 0)

end
end
end

end)

function DisableNades(npc)

if npc:GetNWBool("HasDroppedGrenade", false) == true and GetConVar("GrenadeCarryDisableNades"):GetBool() then
npc:SetKeyValue("NumGrenades", 0)
end

end