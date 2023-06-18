hook.Add( "PopulateToolMenu", "GrenadeDetonationSettingsHitbox", function()

	spawnmenu.AddToolMenuOption( "Options", "Grenade Detonation Settings", "GrenadeDetonationMenuHitbox", "Hitbox Settings", "", "", function( panel )
	panel:ClearControls()

	local HitboxChoice = panel:ComboBox("Hitbox Type", "DetonationHitboxType")
	HitboxChoice:SetSortItems(false)
	HitboxChoice:AddChoice("Spherical", "1")
	HitboxChoice:AddChoice("Cubical", "2")
	HitboxChoice:AddChoice("Grenade", "3")
	HitboxChoice:AddChoice("Custom", "4")
	panel:Help( "Select the style of hitbox for the grenades. Affects the size and shape of the hitbox, has no effect on the grenade itself." )

	panel:AddControl("TextBox", {
	Label = "Custom model",
	Command = "DetonationHitboxModel", })
	panel:Help( "Use a custom model for the hitbox. Use the 'Custom' option for this to function.")


	panel:Button("Create test object", "DetonationTestObject")
	panel:Help( "Creates a grenade model with a wireframe of the current hitbox that can be shot. Use this to customize and choose a hitbox model that suits you best.\n\nShooting the hitbox will change its color according to damage dealt:\n -Yellow means the damage would cause the grenade to become armed.\n -Red means the damage would cause the grenade to detonate." )
	panel:Button("Delete test object", "DetonationDeleteObject")
	panel:Help( "Delete the test object." )
end)
end)