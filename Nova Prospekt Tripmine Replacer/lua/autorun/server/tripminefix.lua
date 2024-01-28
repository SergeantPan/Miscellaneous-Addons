function ReplaceSet(set, ent)

SLAM1 = ents.Create("npc_tripmine")
SLAM2 = ents.Create("npc_tripmine")
SLAM3 = ents.Create("npc_tripmine")
SLAM4 = ents.Create("npc_tripmine")
SLAM5 = ents.Create("npc_tripmine")
SLAM6 = ents.Create("npc_tripmine")
SLAM7 = ents.Create("npc_tripmine")

if set == 1 then

timer.Simple(1.1, function()
if IsValid(ent) then
ent:TakeDamage(ent:Health())

timer.Simple(0.5, function()
SLAM1:SetPos(Vector(-3503.031250, 4659.468750, 153.306747))
SLAM1:SetAngles(Angle(90, 180, 0))
SLAM1:Spawn()
end)
end
end)

end

if set == 2 then

timer.Simple(1.1, function()
if IsValid(ent) then
ent:TakeDamage(ent:Health())

timer.Simple(0.5, function()
SLAM1:SetPos(Vector(-828.968750, 1202.757324, 143.352432))
SLAM1:SetAngles(Angle(90, 0, 0))
SLAM1:Spawn()
SLAM2:SetPos(Vector(-892.968750, 1686.001099, 143.930023))
SLAM2:SetAngles(Angle(90, 0, 0))
SLAM2:Spawn()
SLAM3:SetPos(Vector(-892.968750, 2655.507324, 141.006973))
SLAM3:SetAngles(Angle(90, 0, 0))
SLAM3:Spawn()
SLAM4:SetPos(Vector(-416.010101, 2620.968750, 395.989380))
SLAM4:SetAngles(Angle(90, 270, 0))
SLAM4:Spawn()
SLAM5:SetPos(Vector(-1113.494019, 2115.031250, 396.103241))
SLAM5:SetAngles(Angle(90, 90, 0))
SLAM5:Spawn()
end)
end
end)

end

if set == 3 then

timer.Simple(1.1, function()
if IsValid(ent) then
ent:TakeDamage(ent:Health())

timer.Simple(0.5, function()
SLAM1:SetPos(Vector(-2105.905273, -572.968750, 531.286255))
SLAM1:SetAngles(Angle(90, 90, 0))
SLAM1:Spawn()
SLAM2:SetPos(Vector(-1382.281372, -979.011230, 525.929260))
SLAM2:SetAngles(Angle(90, 270, 0))
SLAM2:Spawn()
SLAM3:SetPos(Vector(-957.391663, -979.011230, 524.795532))
SLAM3:SetAngles(Angle(90, 270, 0))
SLAM3:Spawn()
SLAM4:SetPos(Vector(-950.933655, -1212.968750, 587.963745))
SLAM4:SetAngles(Angle(90, 90, 0))
SLAM4:Spawn()
SLAM5:SetPos(Vector(-844.968750, -951.221436, 522.969299))
SLAM5:SetAngles(Angle(90, 0, 0))
SLAM5:Spawn()
SLAM6:SetPos(Vector(-892.968750, -84.720947, 523.833496))
SLAM6:SetAngles(Angle(90, 0, 0))
SLAM6:Spawn()
SLAM7:SetPos(Vector(-323.031250, 2079.142822, 410.951508))
SLAM7:SetAngles(Angle(90, 180, 0))
SLAM7:Spawn()
end)
end
end)

end

if set == 4 then

timer.Simple(1.1, function()
if IsValid(ent) then
ent:TakeDamage(ent:Health())

timer.Simple(0.5, function()
SLAM1:SetPos(Vector(1180.270996, -1871.316895, -236.968750))

SLAM1:SetAngles(Angle(360, 0, 0))
SLAM1:Spawn()
end)
end
end)

end

end

hook.Add("PostCleanupMap", "NovaCleanup", function()

for _,Mine in pairs(ents.FindByClass("func_breakable")) do
if IsValid(Mine) and string.find(Mine:GetName(), "slam_") then

if game.GetMap() == "d2_prison_03" then
ReplaceSet(1, Mine)
elseif game.GetMap() == "d2_prison_04" then
ReplaceSet(2, Mine)
elseif game.GetMap() == "d2_prison_05" then
ReplaceSet(3, Mine)
elseif game.GetMap() == "d2_prison_06" then
ReplaceSet(4, Mine)
end

end
end

end)

hook.Add("InitPostEntity", "ReplaceNovaProspektFakeMines", function()

for _,Mine in pairs(ents.FindByClass("func_breakable")) do
if IsValid(Mine) and string.find(Mine:GetName(), "slam_") then

if game.GetMap() == "d2_prison_03" then
ReplaceSet(1, Mine)
elseif game.GetMap() == "d2_prison_04" then
ReplaceSet(2, Mine)
elseif game.GetMap() == "d2_prison_05" then
ReplaceSet(3, Mine)
elseif game.GetMap() == "d2_prison_06" then
ReplaceSet(4, Mine)
end

end
end

end)