hook.Add( "Think", "Maybeworks", function()
	ModelBlacklist = string.Split(GetConVar("GrenadeCarryPhysicalModelBlacklist"):GetString(), ", ")

if IsValid(LocalPlayer()) then
	EyeTrace = LocalPlayer():GetEyeTrace().Entity
end
end)

hook.Add( "PopulateToolMenu", "GrenadeDetonationSettingsBlacklist", function()
	local ConVar = GetConVar("GrenadeCarryPhysicalModelBlacklist")

	spawnmenu.AddToolMenuOption( "Options", "Grenade Detonation Settings", "GrenadeDetonationMenuBlacklist", "Model Blacklist", "", "", function( panel )
	panel:ClearControls()

	panel:ControlHelp("\nThe blacklist prevents specific NPC models from using the physical grenade system. This is good for models that either look bad with the grenade on their model, or for restricting the physical grenades system to specific models.\n\nNote that this does not affect the hitbox-based system, only the physical model system.")

	local list = vgui.Create("DListView", frame)
	list:AddColumn("Model")
	list:SetTall(500)

	local Button = vgui.Create("DButton", frame)
	Button:SetText("Add/Remove Model from blacklist")
	Button.DoClick = function()
	if IsValid(EyeTrace) and EyeTrace:IsNPC() then
		if !table.HasValue(ModelBlacklist, EyeTrace:GetModel()) then
			if ConVar:GetString() != "" then
			RunConsoleCommand("GrenadeCarryPhysicalModelBlacklist", ConVar:GetString() .. ", " .. EyeTrace:GetModel())
			else
			RunConsoleCommand("GrenadeCarryPhysicalModelBlacklist", EyeTrace:GetModel())
			end
			list:AddLine(tostring(EyeTrace:GetModel()))
		else
			if string.match(ConVar:GetString(), EyeTrace:GetModel() .. ", ") then
			RunConsoleCommand("GrenadeCarryPhysicalModelBlacklist", string.Replace(ConVar:GetString(), EyeTrace:GetModel() .. ", ", ""))
			elseif string.match(ConVar:GetString(), ", " .. EyeTrace:GetModel()) then
			RunConsoleCommand("GrenadeCarryPhysicalModelBlacklist", string.Replace(ConVar:GetString(), ", " .. EyeTrace:GetModel(), ""))
			else
			RunConsoleCommand("GrenadeCarryPhysicalModelBlacklist", string.Replace(ConVar:GetString(), EyeTrace:GetModel(), ""))
			end
			for Val,Lines in pairs(list:GetLines()) do
			if Lines:GetValue(1) == EyeTrace:GetModel() then
				list:RemoveLine(Val)
			end
			end
		end
	end
	end

	panel:AddItem(Button)
	panel:Help("Use this button to add/remove models from the blacklist. Models will show up on the list below.")
	panel:AddItem(list)

	for _,Model in pairs(ModelBlacklist) do
	if Model != "" then
	list:AddLine(tostring(Model))
	end
	end

	panel:TextEntry("Model Blacklist", "GrenadeCarryPhysicalModelBlacklist")
	panel:Help("Manual list for blacklisting models")

end)
end)