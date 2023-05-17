hook.Add( "PopulateToolMenu", "BarrelKickersSettingsNPCs", function()

	spawnmenu.AddToolMenuOption( "Options", "Barrel Kickers Settings", "BarrelKickersNPCMenu", "Barrel Kickers (NPCs)", "", "", function( panel )
	panel:ClearControls()

	panel:CheckBox( "Allow NPCs to kick barrels", "BarrelKickersNPCCanActivate" )
	panel:CheckBox( "Only allow certain NPCs to kick barrels", "BarrelKickersNPCRestricted" )
	panel:Help("Humans, Combine and zombies")
	panel:CheckBox( "Allow NPC's to ignite kicked barrels", "BarrelKickersNPCCanIgnite" )
	panel:NumSlider( "NPC kicking Strength", "BarrelKickersNPCStrength", 400, 5000, 0 )
	panel:Help("The amount of force a barrel is flung with when kicked by an NPC")
end)
end)