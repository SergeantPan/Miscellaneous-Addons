CreateConVar("DetonationEnabled", 1, 128, "Enable/Disable the grenade detonation function.")

CreateConVar("DetonationDamage", 75, 128, "Damage dealt by detonated grenades. Default is 75 (Default damage of NPC-thrown grenades.)")
CreateConVar("DetonationRadius", 250, 128, "Radius of detonated grenades. Default is 250 (Default explosion radius of HL2 grenades.)")

CreateConVar("DetonationHitboxType", 1, 128, "Choose the type of hitbox the grenade should use./n- 1 = Sphere Model/n- 2 = Cube Model/n- 3 = Grenade model/n- 4 = Custom model")
CreateConVar("DetonationHitboxModel", "", 128, "Use a custom model for the hitbox of the grenade. Requires 'DetonationHitboxType' to be set to 4")

CreateConVar("DetonationDetBulletDamage", 1, 128, "Grenades can be detonated by bullet damage. 1 = Yes, 0 = No")
CreateConVar("DetonationDetExploDamage", 1, 128, "Grenades can be detonated by explosive damage. 1 = Yes, 0 = No")
CreateConVar("DetonationDetAnyDamage", 0, 128, "Grenades can be detonated by ANY type of damage. 1 = Yes, 0 = No")
CreateConVar("DetonationDetDamage", 7, 128, "Damage required for a grenade to detonate. Default is 7")
CreateConVar("DetonationDetChance", 100, 128, "Chance for a grenade to detonate from damage. Percentage chance")

CreateConVar("DetonationArmEnabled", 1, 128, "Enable/Disable the grenade arming function.")

CreateConVar("DetonationArmBulletDamage", 1, 128, "Grenades can be armed by bullet damage. 1 = Yes, 0 = No")
CreateConVar("DetonationArmExploDamage", 0, 128, "Grenades can be armed by explosive damage. 1 = Yes, 0 = No")
CreateConVar("DetonationArmAnyDamage", 0, 128, "Grenades can be armed by ANY type of damage. 1 = Yes, 0 = No")
CreateConVar("DetonationArmDamage", 4, 128, "Damage required for a grenade to get armed, Default is 4")
CreateConVar("DetonationArmChance", 100, 128, "Chance for a grenade to get armed from damage. Percentage chance")

hook.Add( "PhysgunPickup", "CantPickItUp", function(ent)
if ent:GetName() == "GrenDetEnt" then return false
end
end)

// Make it so the player can't use the physgun to pick up the custom prop we create

hook.Add( "PostEntityTakeDamage", "ShootableGrenades", function( target, dmginfo )

local GrenadeDebug = (target:GetClass() == "prop_physics" and target:GetName() == "GrenDetEnt")

// Simplifies getting the created entity

if GetConVar("DetonationArmEnabled"):GetBool() then

// Check if the function is enabled to begin with

if target:GetClass() == "weapon_frag" and dmginfo:GetDamage() < GetConVar("DetonationDetDamage"):GetInt() and dmginfo:GetDamage() > GetConVar("DetonationArmDamage"):GetInt() and IsValid(target) then

// Check that the entity is the weapon type that the player can pick up
// Then check that the damage is less than the detonation threshold, but greater than the arming threshold
// Then ensure the entity is actually valid, and that it exists

if (dmginfo:IsDamageType(DMG_BULLET) and GetConVar("DetonationArmBulletDamage"):GetBool()) or (dmginfo:IsExplosionDamage() and GetConVar("DetonationArmExploDamage"):GetBool() and dmginfo:GetAttacker():GetPos():Distance(target:GetPos()) < GetConVar("DetonationRadius"):GetInt() / 2) or (GetConVar("DetonationArmAnyDamage"):GetBool() and (!dmginfo:IsExplosionDamage() or (dmginfo:IsExplosionDamage() and dmginfo:GetAttacker():GetPos():Distance(target:GetPos()) < GetConVar("DetonationRadius"):GetInt() / 2))) then

// If it's bullet damage, then check if the option to arm via bullet damage is set
// Same for explosive damage, but make sure the source of the damage is close enough
// This is to prevent dodgy behavior, where grenades at the edge of an explosion get armed

if math.Rand(1, 100) < GetConVar("DetonationArmChance"):GetInt() then

// Random chance function

local GrenadeSpawned = ents.Create("npc_grenade_frag") // We create a live grenade

GrenadeSpawned:SetPos(target:GetPos()) // Set its position to the grenade that was shot
GrenadeSpawned:SetAngles(target:GetAngles()) // Do the same for angles
GrenadeSpawned:Spawn() // Create it
GrenadeSpawned:SetHealth(math.huge) // Excessively high health to ensure it does not detonate multiple times (dumb)
GrenadeSpawned:GetPhysicsObject():SetVelocity(target:GetVelocity()) // Give it the velocity of the entity we replaced
GrenadeSpawned:Fire("SetTimer", 3, 0) // Set the fuse to 3 seconds, the default timer for HL2 grenades

target:Remove() // Remove the original entity

end
end
end

if dmginfo:GetDamage() > GetConVar("DetonationDetDamage"):GetInt() then

if (GrenadeDebug or target:GetClass() == "weapon_frag") and IsValid(target) then

// Check that it's either the custom entity, or the weapon type
// Also check for validity, to ensure functionality

if (dmginfo:IsDamageType(DMG_BULLET) and GetConVar("DetonationDetBulletDamage"):GetBool() and target.DamageTaken == nil) or (dmginfo:IsExplosionDamage() and GetConVar("DetonationDetExploDamage"):GetBool() and target.DamageTaken == nil) or (GetConVar("DetonationDetAnyDamage"):GetBool() and target.DamageTaken == nil) then

// CHeck for damage type, and then check that the approriate setting is enabled
// target.DamageTaken ensures the entity only activates this function once

if math.Rand(1, 100) < GetConVar("DetonationDetChance"):GetInt() then

// Random chance function

target.DamageTaken = true // Set the DamageTaken variable
target:Remove() // Remove the target

if GrenadeDebug then // If we are hitting the created prop instead of the weapon entity
target:GetParent():Remove() // Remove the weapon entity (to which the prop is parented to) aswell
end

local GrenadeDetonation = ents.Create( "env_explosion" ) // Create explosion

GrenadeDetonation:SetPos( target:GetPos() ) // Position
GrenadeDetonation:SetKeyValue( "fireballsprite", "effects/fire_cloud2.vmt" ) // Set the effect
GrenadeDetonation:SetKeyValue( "spawnflags", bit.bor(GrenadeDetonation:GetSpawnFlags() + 32) ) // Make it not have sparks
GrenadeDetonation:SetKeyValue( "IMagnitude", GetConVar("DetonationDamage"):GetInt() ) // Set the damage dealt by the explosion
GrenadeDetonation:SetKeyValue( "IRadiusOverride", GetConVar("DetonationRadius"):GetInt() ) // Set the radius of the explosion
GrenadeDetonation:Spawn() // Create it
GrenadeDetonation:Fire( "Explode", 0, 0.1 ) // Detonate it on a short delay, to ensure functionality

end
end
end
end
end
end)

hook.Add( "OnEntityCreated", "GrenadeSwapparoo", function( ent )

// Here, we create an invisible prop to act as the hitbox
// In the game, the grenades cannot be hit by bullets
// Thus, we have to use this as a workaround to create a hitbox for the grenade

if GetConVar("DetonationEnabled"):GetBool() then

if ent:GetClass() == "npc_grenade_frag" and IsValid(ent) then

// Make sure its the active grenade and it's valid

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

// Change the model of the prop, depending on what the player wants
// If the model is not valid, or the setting is outside the range, revert to default

if GetConVar("DetonationHitboxType"):GetInt() == 4 and !IsValid(GetConVar("DetonationHitboxModel"):GetString()) and GetConVar("DetonationHitboxModel"):GetString() != "" then
print("The model " .. GetConVar("DetonationHitboxModel"):GetString() .. " is not valid.")
print("Either the model does not exist, or you've made a typo")
elseif GetConVar("DetonationHitboxType"):GetInt() == 4 and GetConVar("DetonationHitboxModel"):GetString() == "" then
print("You have chosen custom hitbox model, but have left the text field empty.")
print("Please place a valid model path in the text field to apply a custom model.")
elseif GetConVar("DetonationHitboxType"):GetInt() < 1 or GetConVar("DetonationHitboxType"):GetInt() > 4 then
print(GetConVar("DetonationHitboxType"):GetString() .. " is not a valid value")
print("Choose a value between 1-4")
end

// The console command can fail due to missing models, or simply using a variable that doesn't function
// So, print a message in the console to warn the user

local GrenadeAttach = ents.Create("prop_physics") // Create a physics object
GrenadeAttach:SetModel(HitboxModel) // Set the model
GrenadeAttach:SetAngles(ent:GetAngles()) // Get the angle of the object
GrenadeAttach:SetPos(ent:WorldSpaceCenter()) // Position
GrenadeAttach:SetParent(ent) // Parent it (sticks to the object)
GrenadeAttach:SetCollisionGroup(11) // Make it not collide with the player, the grenade or the world
GrenadeAttach:SetColor(Color(0,0,0,0)) // Make it invisible
GrenadeAttach:DrawShadow(false) // Remove the shadow
GrenadeAttach:SetRenderMode( RENDERMODE_TRANSCOLOR ) // Make the color function actually do its thing
GrenadeAttach:SetName("GrenDetEnt") // Entity name, for functionality
GrenadeAttach:Spawn() // Create it

timer.Simple(2.5, function() if IsValid(GrenadeAttach) then GrenadeAttach:Remove() end end)
// Basic timer that removes the prop before the grenade detonates
// Further failsafe to ensure that the grenades don't end up detonating excessively

end
end

end)