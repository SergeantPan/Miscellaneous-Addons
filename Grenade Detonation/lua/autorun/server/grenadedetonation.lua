CreateConVar("DetonationEnabled", 1, 128, "Enable/Disable the grenade detonation function.")

CreateConVar("SMGGrenDetonation", 1, 128, "Enable/Disable the SMG grenade detonation function.")

CreateConVar("DetonationDamage", 75, 128, "Damage dealt by detonated grenades. Default is 75 (Default damage of NPC-thrown grenades.)")
CreateConVar("DetonationRadius", 250, 128, "Radius of detonated grenades. Default is 250 (Default explosion radius of HL2 grenades.)")

CreateConVar("DetonationHitboxType", 1, 128, "Choose the type of hitbox the grenade should use.\n- 1 = Sphere Model\n- 2 = Cube Model\n- 3 = Grenade model\n- 4 = Custom model")
CreateConVar("DetonationHitboxModel", "", 128, "Use a custom model for the hitbox of the grenade. Requires 'DetonationHitboxType' to be set to 4")

CreateConVar("SMGDetonationHitboxType", 1, 128, "Choose the type of hitbox the SMG grenade should use.\n- 1 = Sphere Model\n- 2 = Cube Model\n- 3 = Grenade model\n- 4 = Custom model")
CreateConVar("SMGDetonationHitboxModel", "", 128, "Use a custom model for the hitbox of the SMG grenade. Requires 'DetonationHitboxType' to be set to 4")

CreateConVar("DetonationDetBulletDamage", 1, 128, "Grenades can be detonated by bullet damage. 1 = Yes, 0 = No")
CreateConVar("DetonationDetExploDamage", 1, 128, "Grenades can be detonated by explosive damage. 1 = Yes, 0 = No")
CreateConVar("DetonationDetAnyDamage", 0, 128, "Grenades can be detonated by ANY type of damage. 1 = Yes, 0 = No")
CreateConVar("DetonationDetDamage", 7, 128, "Damage required for a grenade to detonate. Default is 7")
CreateConVar("DetonationDetChance", 100, 128, "Chance for a grenade to detonate from damage. Percentage chance")
CreateConVar("DetonationDetFragile", 0, 128, "Live grenades will always detonate from bullet damage, regardless of actual damage dealt. 1 = Yes, 0 = No")

CreateConVar("DetonationArmEnabled", 1, 128, "Enable/Disable the grenade arming function.")

CreateConVar("DetonationArmBulletDamage", 1, 128, "Grenades can be armed by bullet damage. 1 = Yes, 0 = No")
CreateConVar("DetonationArmExploDamage", 0, 128, "Grenades can be armed by explosive damage. 1 = Yes, 0 = No")
CreateConVar("DetonationArmAnyDamage", 0, 128, "Grenades can be armed by ANY type of damage. 1 = Yes, 0 = No")
CreateConVar("DetonationArmDamage", 4, 128, "Damage required for a grenade to get armed, Default is 4")
CreateConVar("DetonationArmChance", 100, 128, "Chance for a grenade to get armed from damage. Percentage chance")

hook.Add( "PhysgunPickup", "CantPickItUp", function(ply, ent)
if (ent:GetName() == "GrenDetEnt" or ent:GetName() == "Target Object" or ent:GetName() == "Target Object 2") then return false
end
end)

hook.Add( "AllowPlayerPickup", "CantPickItUp2", function(ply, ent)
if (ent:GetName() == "GrenDetEnt" or ent:GetName() == "Target Object") and ent:GetParent() != "grenade_ar2" then
ply:PickupObject(ent:GetParent())
end
end)

hook.Add( "PostEntityTakeDamage", "ShootableGrenades", function( target, dmginfo )

inflictor = dmginfo:GetInflictor()

local GrenadeDebug = (target:GetClass() == "prop_physics" and target:GetName() == "GrenDetEnt")

if GetConVar("DetonationArmEnabled"):GetBool() then

if GrenadeDebug and dmginfo:GetDamage() < GetConVar("DetonationArmDamage"):GetInt() then
target:GetParent():TakePhysicsDamage(dmginfo)
end

if target:GetClass() == "weapon_frag" and dmginfo:GetDamage() < GetConVar("DetonationDetDamage"):GetInt() and dmginfo:GetDamage() > GetConVar("DetonationArmDamage"):GetInt() and IsValid(target) then

if (dmginfo:IsDamageType(DMG_BULLET) and GetConVar("DetonationArmBulletDamage"):GetBool()) or (dmginfo:IsExplosionDamage() and GetConVar("DetonationArmExploDamage"):GetBool() and dmginfo:GetAttacker():GetPos():Distance(target:GetPos()) < GetConVar("DetonationRadius"):GetInt() / 2) or (GetConVar("DetonationArmAnyDamage"):GetBool() and (!dmginfo:IsExplosionDamage() or (dmginfo:IsExplosionDamage() and dmginfo:GetAttacker():GetPos():Distance(target:GetPos()) < GetConVar("DetonationRadius"):GetInt() / 2))) then

if math.Rand(1, 100) < GetConVar("DetonationArmChance"):GetInt() then

local GrenadeSpawned = ents.Create("npc_grenade_frag")

GrenadeSpawned:SetPos(target:GetPos())
GrenadeSpawned:SetAngles(target:GetAngles())
GrenadeSpawned:SetOwner(owner)
GrenadeSpawned:Spawn()
GrenadeSpawned:SetHealth(math.huge)
GrenadeSpawned:GetPhysicsObject():SetVelocity(target:GetVelocity())
GrenadeSpawned:Fire("SetTimer", 3, 0)

target:Remove()

end
end
end

if dmginfo:GetDamage() > GetConVar("DetonationDetDamage"):GetInt() or (GetConVar("DetonationDetFragile"):GetBool() and dmginfo:IsDamageType(DMG_BULLET) and GrenadeDebug) then

if (GrenadeDebug or target:GetClass() == "weapon_frag") and IsValid(target) and inflictor:GetClass() != "grenade_ar2" then

if (dmginfo:IsDamageType(DMG_BULLET) and GetConVar("DetonationDetBulletDamage"):GetBool() and target.DamageTaken == nil) or (dmginfo:IsExplosionDamage() and GetConVar("DetonationDetExploDamage"):GetBool() and target.DamageTaken == nil) or (GetConVar("DetonationDetAnyDamage"):GetBool() and target.DamageTaken == nil) then

if math.Rand(1, 100) < GetConVar("DetonationDetChance"):GetInt() then

target.DamageTaken = true
target:Remove()

if GrenadeDebug then
target:GetParent():Remove()
end

local GrenadeDetonation = ents.Create( "env_explosion" )

GrenadeDetonation:SetPos( target:GetPos() )
GrenadeDetonation:SetKeyValue( "fireballsprite", "effects/fire_cloud2.vmt" )
GrenadeDetonation:SetKeyValue( "spawnflags", bit.bor(GrenadeDetonation:GetSpawnFlags() + 32) )
GrenadeDetonation:SetKeyValue( "IMagnitude", GetConVar("DetonationDamage"):GetInt() )
GrenadeDetonation:SetKeyValue( "IRadiusOverride", GetConVar("DetonationRadius"):GetInt() )
GrenadeDetonation:SetOwner(dmginfo:GetAttacker())
GrenadeDetonation:SetName("DetonationExplosion")
GrenadeDetonation:Spawn()
GrenadeDetonation:Fire( "Explode", 0, 0.1 )

end
end
end
end
end

end)

hook.Add( "OnEntityCreated", "GrenadeSwapparoo", function( ent )

if GetConVar("DetonationEnabled"):GetBool() then

if ent:GetClass() == "npc_grenade_frag" and IsValid(ent) then

if GetConVar("DetonationHitboxType"):GetInt() == 1 then
HitboxModel = "models/dav0r/hoverball.mdl"
elseif GetConVar("DetonationHitboxType"):GetInt() == 2 then
HitboxModel = "models/hunter/blocks/cube025x025x025.mdl"
elseif GetConVar("DetonationHitboxType"):GetInt() == 3 then
HitboxModel = "models/Items/grenadeAmmo.mdl"
elseif GetConVar("DetonationHitboxType"):GetInt() == 4 and util.IsValidModel(GetConVar("DetonationHitboxModel"):GetString()) then
HitboxModel =  GetConVar("DetonationHitboxModel"):GetString()
else
HitboxModel = "models/dav0r/hoverball.mdl"
end

local GrenadeAttach = ents.Create("prop_physics")
GrenadeAttach:SetModel(HitboxModel)
GrenadeAttach:SetAngles(ent:GetAngles())
GrenadeAttach:SetPos(ent:GetPos())
GrenadeAttach:SetParent(ent)
GrenadeAttach:SetCollisionGroup(11)
GrenadeAttach:SetColor(Color(0,0,0,0))
GrenadeAttach:DrawShadow(false)
GrenadeAttach:SetRenderMode( RENDERMODE_TRANSCOLOR )
GrenadeAttach:SetName("GrenDetEnt")
GrenadeAttach:Spawn()

timer.Simple(2.5, function() if IsValid(GrenadeAttach) then GrenadeAttach:Remove() end end)

end
end

end)

hook.Add( "OnEntityCreated", "SMGGrenAdd", function( ent )

if GetConVar("SMGGrenDetonation"):GetBool() then

if ent:GetClass() == "grenade_ar2" and IsValid(ent) then

if GetConVar("DetonationHitboxType"):GetInt() == 1 then
HitboxModel = "models/dav0r/hoverball.mdl"
elseif GetConVar("DetonationHitboxType"):GetInt() == 2 then
HitboxModel = "models/hunter/blocks/cube025x025x025.mdl"
elseif GetConVar("DetonationHitboxType"):GetInt() == 3 then
HitboxModel = "models/Items/AR2_Grenade.mdl"
elseif GetConVar("DetonationHitboxType"):GetInt() == 4 and util.IsValidModel(GetConVar("DetonationHitboxModel"):GetString()) then
HitboxModel =  GetConVar("DetonationHitboxModel"):GetString()
else
HitboxModel = "models/dav0r/hoverball.mdl"
end

local SMGGrenAdd = ents.Create("prop_physics")
SMGGrenAdd:SetModel(HitboxModel)
SMGGrenAdd:SetAngles(ent:GetAngles())
SMGGrenAdd:SetPos(ent:GetPos())
SMGGrenAdd:SetParent(ent)
SMGGrenAdd:SetCollisionGroup(11)
SMGGrenAdd:SetColor(Color(0,0,0,0))
SMGGrenAdd:DrawShadow(false)
SMGGrenAdd:SetRenderMode( RENDERMODE_TRANSCOLOR )
SMGGrenAdd:SetName("GrenDetEnt")
SMGGrenAdd:Spawn()

end
end

end)

hook.Add( "EntityTakeDamage", "SetInflictorLogic", function( target, dmginfo )

inflictor = dmginfo:GetInflictor()

if inflictor:GetClass() == "env_explosion" and inflictor:GetName() == "DetonationExplosion" then
if IsValid(inflictor:GetOwner()) and inflictor:GetOwner():GetActiveWeapon():IsWeapon() then
dmginfo:SetInflictor(inflictor:GetOwner():GetActiveWeapon())
end
end

if inflictor:GetClass() == "npc_grenade_frag" and IsValid(inflictor:GetOwner()) then
dmginfo:SetAttacker(inflictor:GetOwner())
end

end)