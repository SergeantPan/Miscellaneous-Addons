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

concommand.Add("DetonationDeleteObject", function()

for _,TestObjectFound in pairs(ents.FindByClass("prop_physics")) do
if TestObjectFound:GetName() == "Test Object" and IsValid(TestObjectFound) then
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

hook.Add( "PostEntityTakeDamage", "FunWithTesting", function( target, dmginfo )

local GrenadeTest = (target:GetClass() == "prop_physics" and target:GetName() == "Target Object")

if GrenadeTest then

if dmginfo:GetDamage() < GetConVar("DetonationDetDamage"):GetInt() and dmginfo:GetDamage() > GetConVar("DetonationArmDamage"):GetInt() then

target:SetColor(Color(255,255,0,255))

if IsValid(target) then
timer.Simple(2, function() target:SetColor(Color(0,255,0,255)) end)
end

end

if dmginfo:GetDamage() > GetConVar("DetonationDetDamage"):GetInt() then

target:SetColor(Color(255,0,0,255))

if IsValid(target) then
timer.Simple(2, function() target:SetColor(Color(0,255,0,255)) end)
end

end

end

end)