local ExplosiveProps = {"models/nseven/canister01a.mdl", "models/nseven/canister02a.mdl", "models/nseven/propanecanister001a.mdl", "models/nseven/propanecanister001a.mdl", "models/nseven/metalgascan.mdl", "models/props_c17/oildrum001_explosive.mdl", "models/props_junk/gascan001a.mdl", "models/props_c17/canister02a.mdl", "models/props_junk/propane_tank001a.mdl"}

// Create a table for the desired models

local RandomNumber = {1, 2, 3, 5, 6, 7}

// Number table, to emulate random sound effects

hook.Add( "EntityTakeDamage", "NoMoreExplosiveKicks", function( target, dmginfo, attacker, inflictor )

// When any entity takes damage, trigger this function

	if GetConVar("BarrelKickersBluntCanActivate"):GetBool() then
	BluntActivate = true
	else
	BluntActivate = false
	end
	if GetConVar("BarrelKickersSlashCanActivate"):GetBool() then
	SlashActivate = true
	else
	SlashActivate = false
	end
	if GetConVar("BarrelKickersGenericCanActivate"):GetBool() then
	GenericActivate = true
	else
	GenericActivate = false
	end

// Which type of damage can trigger the addon

	local attacker = dmginfo:GetAttacker()
	local inflictor = dmginfo:GetInflictor()

if !GetConVar("BarrelKickersEnabled"):GetBool() then return end // If the addon is not enabled, then stop here

	if attacker:IsPlayer() and GetConVar("BarrelKickersDamageActivation"):GetBool() and (inflictor:IsWeapon() or inflictor:IsPlayer()) then
// Make sure the entity attacking is a player, the addon can be triggered by damage, and the inflictor (object/ent that caused the damage) is a weapon or player

	if table.HasValue(ExplosiveProps, target:GetModel()) then
// Compare the objects model to the table of valid explosive objects

	if (dmginfo:IsDamageType(128) and BluntActivate) or (dmginfo:IsDamageType(4) and SlashActivate) or (bit.bor(dmginfo:GetDamageType()) == 0 and GenericActivate) then
// Check if the damage type corresponds to one that can activate the addon

	target:GetPhysicsObject():AddVelocity( attacker:GetAimVector() * GetConVar("BarrelKickersStrength"):GetInt() )
// Launch the object upwards

	dmginfo:SetDamage(0)
// Make sure we deal no damage to the entity
// This prevents explosive barrels from detonating in the players face

	if GetConVar("BarrelKickersIgniteBarrels"):GetBool() then
// Should the entity get ignited when launched

	target:Ignite(5)

	end
end
end
end
end)

concommand.Add( "KickBarrel", function(ply)

// A console command, that allows for manual kicking

	if GetConVar("BarrelKickersPromptActivation"):GetBool() then
// Check if the command is enabled

	if table.HasValue(ExplosiveProps, ply:GetEyeTrace().Entity:GetModel()) then
// Make sure the object we're looking at is valid

	if ply:GetPos():Distance(ply:GetEyeTrace().Entity:GetPos()) < GetConVar("BarrelKickersDistance"):GetInt() then
// Make sure we are in range

	ply:GetEyeTrace().Entity:GetPhysicsObject():AddVelocity( ply:GetAimVector() * GetConVar("BarrelKickersStrength"):GetInt() )
// Launch the object upwards

	if GetConVar("BarrelKickersIgniteBarrels"):GetBool() then
// Check again if we can ignite the object

	ply:GetEyeTrace().Entity:Ignite(5)
	end

	ply:ViewPunch( Angle( -10, 0, 0 ) )
// Add viewpunch, to make the camera move upwards

	ply:EmitSound( "physics/metal/metal_Barrel_impact_hard" .. table.Random(RandomNumber) .. ".wav" )
// Emit a random metal impact sound, to emulate the sound effect of hitting a metal object

end
end
end
end)

	hook.Add( "HUDPaint", "KickTheBarrel", function()
// We create a funny little icon for the prompt to kick an object

	local ply = LocalPlayer()
	local WhichObject = {}
	local BarrelKickersInc = Material( "KickTheBarrel.png" )

	if !ply:GetEyeTrace().Entity:IsValid() then return end
// Make sure we're looking at a valid object

	if ply:GetEyeTrace().Entity:GetModel() == "models/props_c17/oildrum001_explosive.mdl" then
	WhichObject = "barrel"
	elseif ply:GetEyeTrace().Entity:GetModel() == "models/props_c17/canister02a.mdl" or ply:GetEyeTrace().Entity:GetModel() == "models/nseven/propanecanister001a.mdl" or ply:GetEyeTrace().Entity:GetModel() == "models/nseven/canister01a.mdl" or ply:GetEyeTrace().Entity:GetModel() == "models/nseven/canister02a.mdl" then
	WhichObject = "canister"
	elseif ply:GetEyeTrace().Entity:GetModel() == "models/props_junk/propane_tank001a.mdl" then
	WhichObject = "tank"
	elseif ply:GetEyeTrace().Entity:GetModel() == "models/props_junk/gascan001a.mdl" or ply:GetEyeTrace().Entity:GetModel() == "models/nseven/metalgascan.mdl" then
	WhichObject = "gas can"
	end
// Alter text to match the object we are looking at

	if GetConVar("BarrelKickersEnablePrompt"):GetBool() and GetConVar("BarrelKickersPromptActivation"):GetBool() then
	if table.HasValue(ExplosiveProps, ply:GetEyeTrace().Entity:GetModel()) and input.LookupBinding( "KickBarrel" ) != nil then
	if ply:GetPos():Distance(ply:GetEyeTrace().Entity:GetPos()) < GetConVar("BarrelKickersDistance"):GetInt() then
// Variables according to players settings

	if GetConVar("BarrelKickersEnablePromptIcon"):GetBool() then
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( BarrelKickersInc )
	surface.DrawTexturedRect( ScrW() * GetConVar("BarrelKickersIconXPos"):GetFloat(), ScrH() * GetConVar("BarrelKickersIconYPos"):GetFloat(), 128, 128 )
	end
// If the icon is enabled, then create it, and set it at the position the player wants it to be

	if GetConVar("BarrelKickersEnablePromptText"):GetBool() then
// If text is enabled then

	surface.SetFont( "CloseCaption_Normal" )
	surface.SetTextColor( 255, 255, 255 )
	surface.SetTextPos( ScrW() * GetConVar("BarrelKickersPromptXPos"):GetFloat(), ScrH() * GetConVar("BarrelKickersPromptYPos"):GetFloat() )
	surface.DrawText( "Press " .. string.upper(input.LookupBinding( "KickBarrel" )) .. " to kick the " .. WhichObject )
// Look up which key binding the player has the "KickBarrel" command on, then display that letter in uppercase

	end
end
end
end
end)