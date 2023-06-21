concommand.Add("DetonationTestObject", function(ply)

if GetConVar("DetonationHitboxType"):GetInt() == 1 then
HitboxModel = "models/dav0r/hoverball.mdl"
elseif GetConVar("DetonationHitboxType"):GetInt() == 2 then
HitboxModel = "models/hunter/blocks/cube025x025x025.mdl"
elseif GetConVar("DetonationHitboxType"):GetInt() == 3 then
HitboxModel = "models/Items/grenadeAmmo.mdl"
elseif GetConVar("DetonationHitboxType"):GetInt() == 4 and util.IsValidModel(GetConVar("DetonationHitboxModel"):GetString()) then
HitboxModel =  GetConVar("DetonationHitboxModel"):GetString()
else
HitboxModel = "models/dav0r/hoverball.mdl"
end

for _,TestObjectExists in pairs(ents.FindByClass("prop_physics")) do
if TestObjectExists:GetName() == "Test Object" and IsValid(TestObjectExists) then
	TestObjectExists:Remove()
end
end

local TestObject = ents.Create("prop_physics")
local TestHitbox = ents.Create("prop_physics")

TestObject:SetModel("models/Items/grenadeAmmo.mdl")
TestObject:SetPos(ply:GetEyeTrace().HitPos + Vector(0,0,5))
TestObject:SetName("Test Object")
TestObject:Spawn()

TestHitbox:SetModel(HitboxModel)
TestHitbox:SetPos(TestObject:GetPos())
TestHitbox:SetAngles(TestObject:GetAngles())
TestHitbox:SetParent(TestObject)
TestHitbox:SetCollisionGroup(11)
TestHitbox:SetRenderMode( RENDERMODE_TRANSCOLOR )
TestHitbox:SetColor(Color(0,255,0,255))
TestHitbox:DrawShadow(false)
TestHitbox:SetMaterial("models/wireframe")
TestHitbox:SetName("Target Object")
TestHitbox:Spawn()

end)

concommand.Add("DetonationTestObject2", function(ply)

if GetConVar("SMGDetonationHitboxType"):GetInt() == 1 then
HitboxModel2 = "models/dav0r/hoverball.mdl"
elseif GetConVar("SMGDetonationHitboxType"):GetInt() == 2 then
HitboxModel2 = "models/hunter/blocks/cube025x025x025.mdl"
elseif GetConVar("SMGDetonationHitboxType"):GetInt() == 3 then
HitboxModel2 = "models/Items/AR2_Grenade.mdl"
elseif GetConVar("SMGDetonationHitboxType"):GetInt() == 4 and util.IsValidModel(GetConVar("SMGDetonationHitboxModel"):GetString()) then
HitboxModel2 =  GetConVar("SMGDetonationHitboxModel"):GetString()
else
HitboxModel2 = "models/dav0r/hoverball.mdl"
end

for _,TestObjectExists2 in pairs(ents.FindByClass("prop_physics")) do
if TestObjectExists2:GetName() == "Test Object 2" and IsValid(TestObjectExists2) then
	TestObjectExists2:Remove()
end
end

local TestObject2 = ents.Create("prop_physics")
local TestHitbox2 = ents.Create("prop_physics")

TestObject2:SetModel("models/Items/AR2_Grenade.mdl")
TestObject2:SetPos(ply:GetEyeTrace().HitPos + Vector(0,0,5))
TestObject2:SetName("Test Object 2")
TestObject2:Spawn()

TestHitbox2:SetModel(HitboxModel2)
TestHitbox2:SetPos(TestObject2:GetPos())
TestHitbox2:SetAngles(TestObject2:GetAngles())
TestHitbox2:SetParent(TestObject2)
TestHitbox2:SetCollisionGroup(11)
TestHitbox2:SetRenderMode( RENDERMODE_TRANSCOLOR )
TestHitbox2:SetColor(Color(0,255,0,255))
TestHitbox2:DrawShadow(false)
TestHitbox2:SetMaterial("models/wireframe")
TestHitbox2:SetName("Target Object 2")
TestHitbox2:Spawn()

end)

concommand.Add("DetonationDeleteObject", function()

for _,TestObjectFound in pairs(ents.FindByClass("prop_physics")) do
if (TestObjectFound:GetName() == "Test Object" or TestObjectFound:GetName() == "Test Object 2") and IsValid(TestObjectFound) then
	TestObjectFound:Remove()
local FunnyDetonation = ents.Create( "env_explosion" )
	FunnyDetonation:SetPos(TestObjectFound:GetPos())
	FunnyDetonation:SetKeyValue( "fireballsprite", "effects/fire_cloud2.vmt" )
	FunnyDetonation:SetKeyValue( "spawnflags", bit.bor(FunnyDetonation:GetSpawnFlags() + 48) )
	FunnyDetonation:SetKeyValue( "IMagnitude", "0" )
	FunnyDetonation:SetKeyValue( "IRadiusOverride", "0" )
	FunnyDetonation:Spawn()
	FunnyDetonation:Fire( "Explode", 0, 0.1 )
end
end
end)

hook.Add( "EntityTakeDamage", "FunWithTesting", function( target, dmginfo )

local GrenadeTest = (target:GetClass() == "prop_physics" and target:GetName() == "Target Object")
local SMGGrenadeTest = (target:GetClass() == "prop_physics" and target:GetName() == "Target Object 2")

if GrenadeTest then

if dmginfo:GetDamage() < GetConVar("DetonationDetDamage"):GetInt() and dmginfo:GetDamage() > GetConVar("DetonationArmDamage"):GetInt() then

target:SetColor(Color(255,255,0,255))

timer.Simple(2, function() if IsValid(target) then target:SetColor(Color(0,255,0,255)) end end)

end

if dmginfo:GetDamage() > GetConVar("DetonationDetDamage"):GetInt() then

target:SetColor(Color(255,0,0,255))

timer.Simple(2, function() if IsValid(target) then target:SetColor(Color(0,255,0,255)) end end)

end

end

if SMGGrenadeTest then

if dmginfo:GetDamage() > GetConVar("DetonationDetDamage"):GetInt() then

target:SetColor(Color(255,0,0,255))

timer.Simple(2, function() if IsValid(target) then target:SetColor(Color(0,255,0,255)) end end)

end

end

end)