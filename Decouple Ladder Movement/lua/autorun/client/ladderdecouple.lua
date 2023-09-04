CreateConVar("DecoupleLaddersEnabled", 1, 128, "Enable the 'Decoupled Ladder Movement' addon")

hook.Add("CreateMove", "LadderDecoupling", function(cmd)

if GetConVar("DecoupleLaddersEnabled"):GetBool() and LocalPlayer():GetMoveType() == 9 then

if LocalPlayer():LocalEyeAngles().x > 0 then
if LocalPlayer():KeyDown(8) then
	cmd:SetButtons(cmd:GetButtons() + 8)
end
if LocalPlayer():KeyDown(16) then
	cmd:SetButtons(math.Clamp(cmd:GetButtons() - 8, 0, math.huge))
end
end

end

end)