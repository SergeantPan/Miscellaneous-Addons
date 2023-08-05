hook.Add( "PopulateToolMenu", "GrenadeDetonationSettingsNPCs", function()

	spawnmenu.AddToolMenuOption( "Options", "Grenade Detonation Settings", "GrenadeDetonationMenuNPC", "NPC Grenade Carrying", "", "", function( panel )
	panel:ClearControls()

	panel:CheckBox( "Enable the 'NPCs Drop Grenades' feature", "GrenadeCarryEnabled" )
	panel:Help( "A feature where Combine Soldiers that are shot in the stomach or chest can drop live grenades." )

	panel:NumSlider( "Grenade Drop Chance", "GrenadeCarryChance", 0, 100, 0 )
	panel:Help("Chance for a damaged NPC to drop a grenade.")
	panel:CheckBox( "Prevent Elite Grenade Drops", "GrenadeCarryNoElite" )
	panel:Help( "Combine Elite's will not drop grenades when damaged." )
	panel:CheckBox( "Prevent Grenade Dupes", "GrenadeCarryNoDupes" )
	panel:Help( "NPC's who have already dropped a grenade cannot drop another" )
	local HitboxChoice = panel:ComboBox("Hitbox Setting", "GrenadeCarryHitbox")
	HitboxChoice:SetSortItems(false)
	HitboxChoice:AddChoice("Disabled", "0")
	HitboxChoice:AddChoice("Chest & Stomach", "1")
	HitboxChoice:AddChoice("Chest", "2")
	HitboxChoice:AddChoice("Stomach", "3")
	panel:Help( "Which part of the NPC must be hit in order for a live grenade to drop." )

	panel:CheckBox( "Enable missing hitgroups workaround", "GrenadeCarryBrokenHitgroups" )
	panel:Help( "Certain models can have missing stomach and chest hitgroups. This setting should enable any model to drop grenades." )

	panel:CheckBox( "Disable grenades after drop", "GrenadeCarryDisableNades" )
	panel:Help( "NPCs will no longer be able to throw grenades after dropping one. Requires the Prevent Grenade Dupes setting to be enabled." )

	panel:CheckBox( "Enable physical grenades system for NPCs", "GrenadeCarryPhysical" )
	panel:Help( "NPCs will carry physical grenades on their model, which can be shot to trigger arming or detonation." )
	panel:CheckBox( "NPCs carry grenade on their right", "GrenadeCarrySide" )
	panel:Help( "Changes the physical grenades position from the left side to the right." )

	panel:CheckBox( "NPCs drop a grenade on death", "GrenadeCarryDrop" )
	panel:Help( "NPCs with grenades will drop one on death." )
	panel:CheckBox( "NPCs must have a grenade to drop", "GrenadeCarryDropRequireNade" )
	panel:Help( "NPCs will not drop a grenade on death if they have already dropped one. Requires the Prevent Grenade Dupes setting to be enabled." )
	
end)
end)