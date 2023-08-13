hook.Add( "OnNPCKilled", "NPCDropNades", function( npc )

if GetConVar("GrenadeCarryDrop"):GetBool() and npc:GetClass() == "npc_combine_s" then

if !GetConVar("GrenadeCarryDropRequireNade"):GetBool() or (GetConVar("GrenadeCarryDropRequireNade"):GetBool() and npc:GetNWBool("HasDroppedGrenade", false) == false) then

if !GetConVar("GrenadeCarryNoElite"):GetBool() or (GetConVar("GrenadeCarryNoElite"):GetBool() and npc:GetModel() != "models/combine_super_soldier.mdl") then 

Setup = npc:WorldSpaceCenter() - npc:GetForward()

if GetConVar("GrenadeCarrySide"):GetInt() == 1 then
GrenadePos = Setup + npc:GetRight() * 9
else
GrenadePos = Setup - npc:GetRight() * 9
end

if math.random(1, 100) < GetConVar("GrenadeCarryDropChance"):GetInt() then

DroppedNade = ents.Create("weapon_frag")

if GetConVar("GrenadeCarryPhysical"):GetBool() then
DroppedNade:SetPos(GrenadePos)
else
DroppedNade:SetPos(npc:WorldSpaceCenter())
end

DroppedNade:Spawn()
DroppedNade:SetCollisionGroup(2)

end

end

end

end

end)