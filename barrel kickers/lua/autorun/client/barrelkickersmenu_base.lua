hook.Add( "PopulateToolMenu", "BarrelKickersSettings", function()

	spawnmenu.AddToolMenuOption( "Options", "Barrel Kickers Settings", "BarrelKickersMenu", "Barrel Kickers", "", "", function( panel )
	panel:ClearControls()

	panel:CheckBox( "Enable the 'Barrel Kickers' addon", "BarrelKickersEnabled" )
	panel:CheckBox( "Kick barrels through damage", "BarrelKickersDamageActivation" )
	panel:CheckBox( "Kick barrels through the prompt", "BarrelKickersPromptActivation" )
	panel:CheckBox( "Enable kicking barrels with DMG_Blunt", "BarrelKickersBluntCanActivate" )
	panel:Help("Crowbar, SMod Kick, Stunstick etc.")
	panel:CheckBox( "Enable kicking barrels with DMG_SLASH", "BarrelKickersSlashCanActivate" )
	panel:Help("Bladed weapons, manhacks, antlions etc.")
	panel:CheckBox( "Enable kicking barrels with DMG_GENERIC", "BarrelKickersGenericCanActivate" )
	panel:Help("GMod Fists, some custom weapons.")
	panel:CheckBox( "Kicking barrels ignites them", "BarrelKickersIgniteBarrels" )
	panel:NumSlider( "Kicking Strength", "BarrelKickersStrength", 400, 5000, 0 )
	panel:Help("The amount of force a barrel is flung with when kicked")
	panel:NumSlider( "Kicking Distance", "BarrelKickersDistance", 40, 100, 0 )
	panel:Help("The distance at which you can kick a barrel")
end)
end)