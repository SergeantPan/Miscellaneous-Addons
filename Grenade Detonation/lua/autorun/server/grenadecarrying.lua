CreateConVar("GrenadeCarryEnabled", 1, 128, "Enable the Grenade Carry function")
CreateConVar("GrenadeCarryNPC", 1, 128, "Enable the Grenade Carry function for NPC's")
CreateConVar("GrenadeCarryChance", 20, 128, "Chance for an NPC to drop a live grenade. Value is percentage chance")
CreateConVar("GrenadeCarryNoDupes", 1, 128, "Prevent NPC's from dropping multiple grenades")
CreateConVar("GrenadeCarryHitbox", 1, 128, "Which part of the NPC has to be hit to drop a grenade.\n- 1 = Chest and stomach\n- 2 = Chest\n- 3 = Stomach")
CreateConVar("GrenadeCarryNoElite", 0, 128, "Prevent Combine Elite's from dropping grenades.")
CreateConVar("GrenadeCarryBrokenHitgroups", 0, 128, "Workaround for models that do not support chest and stomach hitgroups")
CreateConVar("GrenadeCarryBrokenHitgroupsPlayer", 0, 128, "Workaround for models that do not support chest and stomach hitgroups")

CreateConVar("GrenadeCarryPlayer", 1, 128, "Enable the Grenade Carry function for players")
CreateConVar("GrenadeCarryPlayerHeld", 1, 128, "Grenades can also be shot out of a players hand.")
CreateConVar("GrenadeCarryPlayerChance", 20, 128, "Chance for a player to drop a live grenade. Value is percentage chance")
CreateConVar("GrenadeCarryPlayerHitbox", 1, 128, "Which part of the player has to be hit to drop a grenade.\n- 1 = Chest and stomach\n- 2 = Chest\n- 3 = Stomach")
CreateConVar("GrenadeCarryRequireAmmo", 1, 128, "Player must have ammo for the grenade to drop a grenade.")
CreateConVar("GrenadeCarryRemoveAmmo", 1, 128, "Remove a grenade from the player when dropping a grenade.")

hook.Add( "ScaleNPCDamage", "ShootableCarriedGrenades", function( npc, hitgroup, dmginfo )

if GetConVar("GrenadeCarryHitbox"):GetInt() == 1 then
HitboxGroup = {2, 3}
elseif GetConVar("GrenadeCarryHitbox"):GetInt() == 2 then
HitboxGroup = {2}
elseif GetConVar("GrenadeCarryHitbox"):GetInt() == 3 then
HitboxGroup = {3}
end

if GetConVar("GrenadeCarryBrokenHitgroups"):GetBool() then
table.insert(HitboxGroup, 0)
else
table.RemoveByValue(HitboxGroup, 0)
end

if GetConVar("GrenadeCarryEnabled"):GetBool() then

if IsValid(npc) and npc:IsNPC() and npc:GetClass() == "npc_combine_s" then

if GetConVar("GrenadeCarryNoElite"):GetBool() and npc:GetModel() == "models/combine_super_soldier.mdl" then return end

if table.HasValue(HitboxGroup, hitgroup) and GetConVar("GrenadeCarryChance"):GetInt() > math.Rand(1, 100) and npc:GetNWBool("HasDroppedGrenade", false) == false then

if npc:GetNWBool("HasDroppedGrenade", false) == false and GetConVar("GrenadeCarryNoDupes"):GetBool() then
npc:SetNWBool("HasDroppedGrenade", true)
end

npc:EmitSound("physics/metal/metal_sheet_impact_bullet1.wav")

local LiveGrenade = ents.Create( "npc_grenade_frag" )

LiveGrenade:SetPos( npc:WorldSpaceCenter() - (npc:GetForward() * 15) )
LiveGrenade:SetCollisionGroup(9)
LiveGrenade:Spawn()
LiveGrenade:GetPhysicsObject():SetVelocity(Vector(math.Rand(-250,250),math.Rand(-250,250),25))
LiveGrenade:Fire("SetTimer", 3, 0)

end
end
end
end)

hook.Add( "ScalePlayerDamage", "ShootableCarriedGrenades", function( ply, hitgroup, dmginfo )

if GetConVar("GrenadeCarryPlayerHitbox"):GetInt() == 1 then
HitboxGroup = {2, 3}
elseif GetConVar("GrenadeCarryPlayerHitbox"):GetInt() == 2 then
HitboxGroup = {2}
elseif GetConVar("GrenadeCarryPlayerHitbox"):GetInt() == 3 then
HitboxGroup = {3}
end

if GetConVar("GrenadeCarryBrokenHitgroupsPlayer"):GetBool() then
table.insert(HitboxGroup, 0)
else
table.RemoveByValue(HitboxGroup, 0)
end

if GetConVar("GrenadeCarryPlayerHeld"):GetBool() and ply:GetActiveWeapon():GetClass() == "weapon_frag" and !table.HasValue(HitboxGroup, "5") then
table.insert(HitboxGroup, 5)
end
if !GetConVar("GrenadeCarryPlayerHeld"):GetBool() or ply:GetActiveWeapon():GetClass() != "weapon_frag" then
table.RemoveByValue(HitboxGroup, 5)
end

if GetConVar("GrenadeCarryPlayer"):GetBool() then

if IsValid(ply) and ply:IsPlayer() then

if table.HasValue(HitboxGroup, hitgroup) and GetConVar("GrenadeCarryPlayerChance"):GetInt() > math.Rand(1, 100) and ply:HasWeapon("weapon_frag") and ((GetConVar("GrenadeCarryRequireAmmo"):GetBool() and ply:GetAmmoCount(10) > 0) or !GetConVar("GrenadeCarryRequireAmmo"):GetBool()) then

if GetConVar("GrenadeCarryRemoveAmmo"):GetBool() then
ply:RemoveAmmo(1, 10)
end

ply:EmitSound("physics/metal/metal_sheet_impact_bullet2.wav")

local LiveGrenade = ents.Create( "npc_grenade_frag" )

if Hitgroup != 5 then
LiveGrenade:SetPos( ply:WorldSpaceCenter() - (ply:GetForward() * 15) )
else
LiveGrenade:SetPos( ply:GetBonePosition(11) )
end
LiveGrenade:SetCollisionGroup(9)
LiveGrenade:Spawn()
LiveGrenade:GetPhysicsObject():SetVelocity(Vector(math.Rand(-250,250),math.Rand(-250,250),25))
LiveGrenade:Fire("SetTimer", 3, 0)

end
end
end
end)