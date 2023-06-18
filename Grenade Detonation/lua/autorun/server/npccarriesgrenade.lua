CreateConVar("GrenadeCarryEnabled", 1, 128, "Enable the NPC's carry grenades function")
CreateConVar("GrenadeCarryChance", 20, 128, "Chance for an NPC to drop a live grenade. Value is percentage chance")
CreateConVar("GrenadeCarryNoDupes", 1, 128, "Prevent NPC's from dropping multiple grenades")
CreateConVar("GrenadeCarryHitbox", 1, 128, "Which part of the NPC has to be hit to drop a grenade.\n- 1 = Chest and stomach\n- 2 = Chest\n- 3 = Stomach")

hook.Add( "ScaleNPCDamage", "ShootableCarriedGrenades", function( npc, hitgroup, dmginfo )

local RandomSound = {"physics/metal/metal_sheet_impact_bullet1.wav", "physics/metal/metal_sheet_impact_bullet2.wav"}

if GetConVar("GrenadeCarryHitbox"):GetInt() == 1 then
HitboxGroup = {2, 3}
elseif GetConVar("GrenadeCarryHitbox"):GetInt() == 2 then
HitboxGroup = {2}
elseif GetConVar("GrenadeCarryHitbox"):GetInt() == 3 then
HitboxGroup = {3}
end

if GetConVar("GrenadeCarryEnabled"):GetBool() then

if IsValid(npc) and npc:IsNPC() and npc:GetClass() == "npc_combine_s" then

if table.HasValue(HitboxGroup, hitgroup) and GetConVar("GrenadeCarryChance"):GetInt() > math.Rand(1, 100) and npc:GetNWBool("HasDroppedGrenade", false) == false then

if npc:GetNWBool("HasDroppedGrenade", false) == false and GetConVar("GrenadeCarryNoDupes"):GetBool() then
npc:SetNWBool("HasDroppedGrenade", true)
end

npc:EmitSound(table.Random(RandomSound))

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