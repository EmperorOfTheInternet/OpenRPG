AddCSLuaFile()

if CLIENT then
	SWEP.PrintName     = "DarkRPG2 Menu"			
	SWEP.Slot			= 1
	SWEP.SlotPos		= 3
	SWEP.DrawAmmo		= false
	SWEP.DrawCrosshair	= false
	SWEP.WepSelectIcon = surface.GetTextureID("HUD/killicons/DARKRPGMENU")
	
	killicon.Add( "darkrpg2_swep", "HUD/killicons/DARKRPGMENU", Color( 255, 80, 0, 255 ) )
end

if SERVER then
	SWEP.Weight			= 0
	SWEP.AutoSwitchTo	= false
	SWEP.AutoSwitchFrom	= false
end

SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true

SWEP.Author			= "Emperor of the Internet"
SWEP.Contact		= "STEAM_0:1:21129987"
SWEP.Instructions	= "Left Click: Stats/Skill Points\nRight Click: Talent Points\nReload:Server Info"
SWEP.Category		= "DarRPG2"

SWEP.HoldType = "none"

SWEP.Primary.Damage	= -1
SWEP.Primary.Delay 	= -1
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.UseHands = true

function SWEP:Initialize()
    self:SetHoldType("normal")
end

function SWEP:Deploy()
    if CLIENT or not IsValid(self:GetOwner()) then return true end
    return true
end

function SWEP:Holster()
    return true
end

function SWEP:PreDrawViewModel()
    return true
end

function SWEP:PrimaryAttack()
	if CLIENT and DarkRPG != nil then
    	DarkRPG.swepSwitchMenu(false,false,true)
	end
	return
end

function SWEP:SecondaryAttack()
	if CLIENT and DarkRPG != nil then
    	DarkRPG.swepSwitchMenu(true,false,false)
	end
	return
end

function SWEP:Reload()
	if CLIENT and DarkRPG != nil then
    	DarkRPG.swepSwitchMenu(false,true,false)
	end
	return
end

function SWEP:OnDrop()
	if self != nil then self:Remove() end
end