net.Receive("HideGrenade", function(ply, len)
HideGren = net.ReadEntity()
end)

hook.Add("Think", "HideGrenade", function(ply)

if IsValid(HideGren) then
HideGren:SetNoDraw(true)
end

end)