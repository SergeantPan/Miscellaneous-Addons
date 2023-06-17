hook.Add( "PopulateToolMenu", "GrenadeDetonationSettingsNPCs", function()

	spawnmenu.AddToolMenuOption( "Options", "Grenade Detonation Settings", "GrenadeDetonationMenuNPC", "NPC Grenade Carrying", "", "", function( panel )
	panel:ClearControls()

	panel:CheckBox( "Enable the 'NPCs Drop Grenades' feature", "GrenadeCarryEnabled" )
	panel:Help( "A feature where Combine Soldiers that are shot in the stomach or chest can drop live grenades." )

	panel:NumSlider( "Grenade Drop Chance", "GrenadeCarryChance", 0, 100, 0 )
	panel:Help("Chance for a damanged NPC to drop a grenade.")
	panel:CheckBox( "Prevent Grenade Dupes", "GrenadeCarryNoDupes" )
	panel:Help( "NPC's who have already dropped a grenade cannot drop another" )
end)
end)