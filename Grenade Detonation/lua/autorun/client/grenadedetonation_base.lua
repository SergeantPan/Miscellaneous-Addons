hook.Add( "PopulateToolMenu", "GrenadeDetonationSettings", function()

	spawnmenu.AddToolMenuOption( "Options", "Grenade Detonation Settings", "GrenadeDetonationMenu", "Grenade Detonation", "", "", function( panel )
	panel:ClearControls()

	panel:CheckBox( "Enable the 'Grenade Detonation' feature", "DetonationEnabled" )

	panel:CheckBox( "Bullet damage can detonate", "DetonationDetBulletDamage" )
	panel:Help( "Can bullets cause detonation?" )
	panel:CheckBox( "Explosive damage can detonate", "DetonationDetExploDamage" )
	panel:Help( "Can explosive damage cause detonation?" )
	panel:CheckBox( "Any damage type can detonate", "DetonationDetAnyDamage" )
	panel:Help( "Allow all damage types to detonate the grenade." )
	panel:CheckBox( "Bullets always detonate", "DetonationDetFragile" )
	panel:Help( "Bullet damage will always detonate live grenades." )
	
	panel:NumSlider( "Detonation Damage", "DetonationDetDamage", 0, 100, 0 )
	panel:Help("Damage required to detonate a grenade. Default is 7.")
	panel:NumSlider( "Detonation Chance", "DetonationDetChance", 0, 100, 0 )
	panel:Help("Chance for damage to detonate a grenade.")

	panel:NumSlider( "Grenade detonation damage", "DetonationDamage", 0, 1000, 0 )
	panel:Help( "How much damage the resulting explosion deals. Default is 75." )
	panel:NumSlider( "Grenade detonation radius", "DetonationRadius", 0, 1000, 0 )
	panel:Help( "The blast radius of the resulting explosion. Default is 250." )

	panel:CheckBox( "Enable the 'Grenade Arming' feature", "DetonationArmEnabled" )

	panel:CheckBox( "Bullet damage can arm", "DetonationArmBulletDamage" )
	panel:Help( "Can bullets cause grenades to become armed?" )
	panel:CheckBox( "Explosive damage can arm.", "DetonationArmExploDamage" )
	panel:Help( "Can explosive damage cause grenades to become armed?" )
	panel:CheckBox( "Any damage can arm", "DetonationArmAnyDamage" )
	panel:Help( "Allow all damage types to arm grenades." )

	panel:NumSlider( "Damage to arm", "DetonationArmDamage", 0, 100, 0 )
	panel:Help("Damage required to arm a grenade. Default is 4.")
	panel:NumSlider( "Arming chance", "DetonationArmChance", 0, 100, 0 )
	panel:Help("Chance for damage to arm a grenade.")
end)
end)