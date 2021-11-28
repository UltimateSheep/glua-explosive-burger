AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/food/burger.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phy = self:GetPhysicsObject()

    if (phy:IsValid()) then
        phy:Wake()
    end    
end




function ENT:Use(ac, ply)
    local weapon = ply:GetActiveWeapon()
    self:Remove()
    
    if (weapon:GetMaxClip1() < 1 ) then 
        local explo = ents.Create( "env_explosion" )
        explo:SetPos( ply:GetPos() )
        explo:Spawn()
        explo:Fire( "Explode" )
        explo:SetKeyValue( "IMagnitude", 50 )
        explo:SetKeyValue("DamageForce", 500)
        return 
    end

    local AmmoType = weapon:GetPrimaryAmmoType()
    local AmmoCount = ply:GetAmmoCount(AmmoType)

    

    ply:SetAmmo(AmmoCount + 1000, AmmoType)
    
end

function ENT:OnTakeDamage(damageinfo)
    local ply = damageinfo:GetAttacker()
    
    if ( ply:IsValid() == false ) then
        print("amogus is not funny")
        return 
    end

    if (ply:IsPlayer() == false ) then
        local explo = ents.Create( "env_explosion" )
        explo:SetPos( self:GetPos() )
        explo:Spawn()
        explo:Fire( "Explode" )
        explo:SetKeyValue( "IMagnitude", 50 )
        explo:SetKeyValue("DamageForce", 500 )
        self:Remove()
        return 
    end
    local weapon = ply:GetActiveWeapon()
    self:Remove()
    
    if (weapon:GetMaxClip1() < 1 ) then 
        local explo = ents.Create( "env_explosion" )
        explo:SetPos( self:GetPos() )
        explo:Spawn()
        explo:Fire( "Explode" )
        explo:SetKeyValue( "IMagnitude", 50 )
        explo:SetKeyValue("DamageForce", 500 )
        return
    end

    local AmmoType = weapon:GetPrimaryAmmoType()
    local AmmoCount = ply:GetAmmoCount(AmmoType)

    ply:SetAmmo(AmmoCount - 1000, AmmoType)
    
    local explo = ents.Create( "env_explosion" )
    explo:SetPos( self:GetPos() )
    explo:Spawn()
    explo:Fire( "Explode" )
    explo:SetKeyValue( "IMagnitude", 50 )
    explo:SetKeyValue("DamageForce", 500 )
    return 
end
