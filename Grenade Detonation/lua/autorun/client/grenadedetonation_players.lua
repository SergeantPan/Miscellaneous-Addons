hook.Add( "PopulateToolMenu", "GrenadeDetonationSettingsPlayers", function()

	spawnmenu.AddToolMenuOption( "Options", "Grenade Detonation Settings", "GrenadeDetonationMenuPly", "Player Grenade Carrying", "", "", function( panel )
	panel:ClearControls()

	panel:CheckBox( "Enable the 'Players Drop Grenades' feature", "GrenadeCarryPlayer" )
	panel:Help( "A feature where players with grenades that are shot in the stomach or chest can drop live grenades." )

	panel:NumSlider( "Grenade Drop Chance", "GrenadeCarryPlayerChance", 0, 100, 0 )
	panel:Help("Chance for a damaged player to drop a grenade.")
	local HitboxChoice = panel:ComboBox("Hitbox Setting", "GrenadeCarryPlayerHitbox")
	HitboxChoice:SetSortItems(false)
	HitboxChoice:AddChoice("Disabled", "0")
	HitboxChoice:AddChoice("Chest & Stomach", "1")
	HitboxChoice:AddChoice("Chest", "2")
	HitboxChoice:AddChoice("Stomach", "3")
	panel:Help( "Which part of the player must be hit in order for a live grenade to drop." )
	panel:CheckBox( "Enable missing hitgroups workaround", "GrenadeCarryBrokenHitgroupsPlayer" )
	panel:Help( "Certain models can have missing stomach and chest hitgroups. This setting should enable any model to drop grenades." )

	panel:CheckBox( "Enable shooting held grenades", "GrenadeCarryPlayerHeld" )
	panel:Help( "Can shooting the arm of a player holding a grenade cause a live grenade to drop? This setting is independent of the hitbox settings above." )

	panel:CheckBox( "Dropping grenades requires ammo", "GrenadeCarryRequireAmmo" )
	panel:Help( "Does a player need to have grenades in their inventory in order to drop one?" )
	panel:CheckBox( "Dropping a grenade removes ammo", "GrenadeCarryRemoveAmmo" )
	panel:Help( "Does dropping a grenade cause the player to lose a grenade?" )

	panel:CheckBox( "Enable physical grenades system for players", "GrenadeCarryPhysicalPly" )
	panel:Help( "Players will carry physical grenades on their model, which can be shot to trigger arming or detonation. Player must have at least one grenade for this to apply" )
	panel:CheckBox( "Players carry grenade on their right", "GrenadeCarrySidePlayer" )
	panel:Help( "Changes the physical grenades position from the left side to the right." )
end)
end)