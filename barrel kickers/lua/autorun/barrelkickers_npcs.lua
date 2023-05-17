local ExplosiveProps = {"models/nseven/canister01a.mdl", "models/nseven/canister02a.mdl", "models/nseven/propanecanister001a.mdl", "models/nseven/propanecanister001a.mdl", "models/nseven/metalgascan.mdl", "models/props_c17/oildrum001_explosive.mdl", "models/props_junk/gascan001a.mdl", "models/props_c17/canister02a.mdl", "models/props_junk/propane_tank001a.mdl"}

hook.Add( "EntityTakeDamage", "NPCExplosiveKicks", function( target, dmginfo, attacker )

	if GetConVar("BarrelKickersBluntCanActivate"):GetBool() then
	NPCBluntActivate = true
	else
	NPCBluntActivate = false
	end
	if GetConVar("BarrelKickersSlashCanActivate"):GetBool() then
	NPCSlashActivate = true
	else
	NPCSlashActivate = false
	end
	if GetConVar("BarrelKickersGenericCanActivate"):GetBool() then
	NPCGenericActivate = true
	else
	NPCGenericActivate = false
	end

	local attacker = dmginfo:GetAttacker()
	local inflictor = dmginfo:GetInflictor()

	local RestrictedNPCs = {"npc_metropolice", "npc_combine_s", "npc_monk", "npc_alyx", "npc_barney", "npc_citizen", "npc_vortigaunt", "npc_zombie", "npc_zombine", "npc_poisonzombie"}

if !GetConVar("BarrelKickersEnabled"):GetBool() then return end

	if (GetConVar("BarrelKickersNPCRestricted"):GetBool() and table.HasValue(RestrictedNPCs, attacker:GetClass())) or !GetConVar("BarrelKickersNPCRestricted"):GetBool() then

	if attacker:IsNPC() and GetConVar("BarrelKickersNPCCanActivate"):GetBool() and (inflictor:IsWeapon() or inflictor:IsNPC()) then

	if table.HasValue(ExplosiveProps, target:GetModel()) then

	if (dmginfo:IsDamageType(128) and NPCBluntActivate) or (dmginfo:IsDamageType(4) and NPCSlashActivate) or (bit.bor(dmginfo:GetDamageType()) == 0 and NPCGenericActivate) then

	target:GetPhysicsObject():AddVelocity( attacker:GetAimVector() * GetConVar("BarrelKickersNPCStrength"):GetInt() )

	dmginfo:SetDamage(0)

	if GetConVar("BarrelKickersIgniteBarrels"):GetBool() and GetConVar("BarrelKickersNPCCanIgnite"):GetBool() then

	target:Ignite(5)

	end
end
end
end
end
end)