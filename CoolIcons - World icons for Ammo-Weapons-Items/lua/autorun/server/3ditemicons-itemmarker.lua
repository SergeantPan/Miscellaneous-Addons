hook.Add( "PlayerTick", "FindItems", function(ply)

local XRayVision = GetConVar("SeeThruWalls"):GetBool()

if XRayVision then return end

// All ammo-type items + Ammo Crates
if GetConVar("AmmoIcon"):GetBool() then
for _,ammo in pairs(ents.FindByClass("*ammo_*")) do
if ammo:Visible(ply) and ammo:GetNWBool("Visible", false) == false then
	ammo:SetNWBool("Visible", true)
elseif !ammo:Visible(ply) and ammo:GetNWBool("Visible", false) == true then
	ammo:SetNWBool("Visible", false)
end
end

// Buckshot, because it has a different name for SOME FUCKING REASON
for _,buckshot in pairs(ents.FindByClass("item_box_buckshot")) do
if buckshot:Visible(ply) and buckshot:GetNWBool("Visible", false) == false then
	buckshot:SetNWBool("Visible", true)
elseif !buckshot:Visible(ply) and buckshot:GetNWBool("Visible", false) == true then
	buckshot:SetNWBool("Visible", false)
end
end
end

// Should get anything that is a weapon
if GetConVar("WeaponIcon"):GetBool() then
for _,wep in pairs(ents.GetAll()) do
local unowned = !wep:GetOwner():IsPlayer() and !wep:GetOwner():IsNPC()
if wep:IsWeapon() and wep:GetClass() != "weapon_frag" and unowned then
if wep:Visible(ply) and wep:GetNWBool("Visible", false) == false then
	wep:SetNWBool("Visible", true)
elseif !wep:Visible(ply) and wep:GetNWBool("Visible", false) == true then
	wep:SetNWBool("Visible", false)
end
end
end
end

if GetConVar("RocketIcon"):GetBool() then
// HL2 Rockets
for _,rocket in pairs(ents.FindByClass("item_rpg_round")) do
if rocket:Visible(ply) and rocket:GetNWBool("Visible", false) == false then
	rocket:SetNWBool("Visible", true)
elseif !rocket:Visible(ply) and rocket:GetNWBool("Visible", false) == true then
	rocket:SetNWBool("Visible", false)
end
end
end

if GetConVar("HealthIcon"):GetBool() or GetConVar("HealthChargerIcon"):GetBool() then
// Health Kits, Vials and Chargers
for _,health in pairs(ents.FindByClass("*health*")) do
if health:Visible(ply) and health:GetNWBool("Visible", false) == false then
	health:SetNWBool("Visible", true)
elseif !health:Visible(ply) and health:GetNWBool("Visible", false) == true then
	health:SetNWBool("Visible", false)
end
end

// ArcCW Med Shots
for _,medshot in pairs (ents.FindByClass("arc_medshot_*")) do
if medshot:Visible(ply) and medshot:GetNWBool("Visible", false) == false then
	medshot:SetNWBool("Visible", true)
elseif !medshot:Visible(ply) and medshot:GetNWBool("Visible", false) == true then
	medshot:SetNWBool("Visible", false)
end
end
end

// Armor Battery
if GetConVar("ArmorIcon"):GetBool() then
for _,batt in pairs(ents.FindByClass("item_battery")) do
if batt:Visible(ply) and batt:GetNWBool("Visible", false) == false then
	batt:SetNWBool("Visible", true)
elseif !batt:Visible(ply) and batt:GetNWBool("Visible", false) == true then
	batt:SetNWBool("Visible", false)
end
end

// Suit Charger
for _,charger in pairs (ents.FindByClass("item_suitcharger")) do
if charger:Visible(ply) and charger:GetNWBool("Visible", false) == false then
	charger:SetNWBool("Visible", true)
elseif !charger:Visible(ply) and charger:GetNWBool("Visible", false) == true then
	charger:SetNWBool("Visible", false)
end
end

// ArcCW Armor Plates for compatibility
for _,armorplate in pairs (ents.FindByClass("armorplate_pickup")) do
if armorplate:Visible(ply) and armorplate:GetNWBool("Visible", false) == false then
	armorplate:SetNWBool("Visible", true)
elseif !armorplate:Visible(ply) and armorplate:GetNWBool("Visible", false) == true then
	armorplate:SetNWBool("Visible", false)
end
end
end

if GetConVar("GrenadeIcon"):GetBool() then
// HL2 Grenades
for _,gren in pairs(ents.FindByClass("weapon_frag")) do
local unowned = !gren:GetOwner():IsPlayer() and !gren:GetOwner():IsNPC()
if unowned and gren:Visible(ply) and gren:GetNWBool("Visible", false) == false then
	gren:SetNWBool("Visible", true)
elseif !gren:Visible(ply) and gren:GetNWBool("Visible", false) == true then
	gren:SetNWBool("Visible", false)
end
end
end

if GetConVar("GrenadeWarningIcon"):GetBool() then
// Live Grenades
for _,grenwar in pairs (ents.FindByClass("npc_grenade_frag")) do
if grenwar:Visible(ply) and grenwar:GetNWBool("Visible", false) == false then
	grenwar:SetNWBool("Visible", true)
elseif !grenwar:Visible(ply) and grenwar:GetNWBool("Visible", false) == true then
	grenwar:SetNWBool("Visible", false)
end
end
end

end)