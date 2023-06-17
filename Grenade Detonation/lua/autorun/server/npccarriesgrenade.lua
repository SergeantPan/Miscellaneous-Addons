CreateConVar("GrenadeCarryEnabled", 1, 128, "Enable the NPC's carry grenades function")
CreateConVar("GrenadeCarryChance", 20, 128, "Chance for an NPC to drop a live grenade. Value is percentage chance")
CreateConVar("GrenadeCarryNoDupes", 1, 128, "Prevent NPC's from dropping multiple grenades")

local RandomSound = {"physics/metal/metal_sheet_impact_bullet1.wav", "physics/metal/metal_sheet_impact_bullet2.wav"} // Random sound effect

hook.Add( "ScaleNPCDamage", "ShootableCarriedGrenades", function( npc, hitgroup, dmginfo )

if GetConVar("GrenadeCarryEnabled"):GetBool() then // Enabled/Disabled check

if IsValid(npc) and npc:IsNPC() and npc:GetClass() == "npc_combine_s" then
// Make sure the NPC is valid, is an NPC, and is the Combine Soldier type

if hitgroup == 2 or hitgroup == 3 and GetConVar("GrenadeCarryChance"):GetInt() > math.Rand(1, 100) and npc.HasDroppedGrenade == nil then
// Check that the hitgroup is either the chest or the stomach, random chance and HasDroppedGrenade is not yet set

if npc.HasDroppedGrenade == nil and GetConVar("GrenadeCarryNoDupes"):GetBool() then
npc.HasDroppedGrenade = true // To prevent duplicate grenades
end

local LiveGrenade = ents.Create( "npc_grenade_frag" )

LiveGrenade:SetPos( npc:WorldSpaceCenter() ) // Center of mass
LiveGrenade:Spawn() // Spawn it
LiveGrenade:Fire("SetTimer", 3, 0) // Set a timer

npc:EmitSound(table.Random(RandomSound)) // Emit a sound

end
end
end
end)