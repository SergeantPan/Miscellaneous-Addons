net.Receive("HideGrenade", function(ply, len)
HideGren = net.ReadEntity()
if IsValid(HideGren) then
HideGren:SetNoDraw(true)
end
end)