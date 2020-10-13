util.AddNetworkString( "drpgps" )
net.Receive("drpgps", function(len, ply)
	DarkRPG.Server.updatePlayerStats(ply, net.ReadTable())
end )

function DarkRPG.weaponCategory(weapons)
	DarkRPG.Server.WeaponCategories[name] = weapons
end

function DarkRPG.Server.updatePlayerStats(ply, info)
	local steamid = {}
	steamid.steamid = ply:SteamID()
	PrintTable(info)
	--if info.key != DarkRPG.Server.Player[steamid.steamid].key then return end
	
	for _, name in pairs( DarkRPG.Server.Stat_VarNames ) do
		steamid[name] = info[name]
	end
	steamid.give = info.give
	steamid.weapon = info.weapon

	DarkRPG.Server.Player[steamid.steamid] = steamid

	if ply:Alive() then 
		DarkRP.notify(ply, 2, 4, "DarkRPG: You must respawn for your settings to take effect.") 
	end
end

function DarkRPG.Server.applyPlayerStats(ply, hp, armor)
	local steamid = DarkRPG.Server.Player[ply:SteamID()]
	if steamid == nil then return end
	ply:SetHealth( ( steamid.health or 100 )*(hp or 1) )
	ply:SetMaxHealth( steamid.health or 100 )
	ply:SetArmor( (steamid.armor or 0)*(armor or 1) )
	ply:SetRunSpeed( steamid.movement or DarkRP.GAMEMODE.Config.runspeed or 240 )
	ply:SetJumpPower( steamid.jump or 200)
end

function DarkRPG.Server.sendLevelToClient(ply)
	ply:DarkRPGUpdateClient( ply, math.Clamp( DarkRPG.Server.determineLevelingSystem(ply), 1, 1024 ) )
end

function DarkRPG.Server.determineLevelingSystem(ply)
	return
		(FindMetaTable( "Player" ))['getDarkRPVar'] != nil and ( ply:getDarkRPVar('level') or ply:getDarkRPVar('lvl') ) or --vrondakis or sf leveling system
		levelup != nil and levelup.getLevel(ply) or -- neth's levelup
		(FindMetaTable( "Player" )).MetaBaseClass['GetNetVar'] != nil and ply:EL_playerLevel() or --elevel
		1 --failed to load
end

util.AddNetworkString("drpgpl")
local meta = FindMetaTable("Player")
function meta:DarkRPGUpdateClient( ply, args )

	local key = math.random(1, DarkRPG.Server.id)
	DarkRPG.Server.Player[ply:SteamID()].key = key

	net.Start("drpgpl")
	net.WriteInt(args, 10)
	net.WriteInt( DarkRPG.Server.id, 30 )
	net.WriteInt( key, 30 )
	net.Send(self)
end

function DarkRPG.playerSpawnTimer( ply, hp, armor )
	timer.Simple( math.Clamp( DarkRPG.Server.EquipTimer , 1, DarkRPG.Server.EquipTimer ), function() 
		if !ply:Alive() then return end
		DarkRPG.Server.sendLevelToClient(ply)
		timer.Simple( 1, function() 
			DarkRPG.Server.applyPlayerStats(ply, hp, armor) -- causes server break b/c nil table info b/c you spawn b4 the info is loaded
			DarkRPG.Server.giveWeapons(ply)
			DarkRPG.Server.scanSpawnedWeapons(ply)
			ply:Give('darkrpg2_swep')
		end)
	end)
end
hook.Add("PlayerSpawn", "DarkRPG_PlayerSpawn", function(ply)
	if ply:IsValid() and ply:IsPlayer() then
		DarkRPG.playerSpawnTimer(ply)
	end
end )

hook.Add("OnPlayerChangedTeam", "DarkRPG_ChangeJob", function(ply) 
	if ply:IsValid() and ply:IsPlayer() then 
		local steamid, hp, armor
		if DarkRP.GAMEMODE.Config.norespawn and ply:Alive() then
			steamid = DarkRPG.Server.Player[ply:SteamID()]
			hp = 1/steamid.health*ply:Health() or 1
			armor = 1/steamid.armor*ply:Armor() or 1
		end
		DarkRPG.Server.Player[ply:SteamID()] = {}
		DarkRPG.playerSpawnTimer(ply, hp, armor)
	end
end )

hook.Add( "PlayerAuthed", "DarkRPG_PlayerJoin", function( ply ) 
	if ply:IsValid() and ply:IsPlayer() then
		DarkRPG.Server.Player[ply:SteamID()] = {} -- attempt to index a string value with bad key ('SteamID' is not part of the string library)
	end
end)

hook.Add( "PlayerDisconnected", "DarkRPG_PlayerLeave", function( ply ) 
	if ply:IsValid() and ply:IsPlayer() then
		DarkRPG.Server.Player[ply:SteamID()] = nil
	end
end)

timer.Create("DarkRPG_CleanUpPlayerTable",3600,0,function()
	local newPly = {}
	for _, ply in pairs( player.GetHumans() ) do
		if ply:IsValid() then 
			local steamid = ply:SteamID()
			newPly[steamid] = DarkRPG.Server.Player[steamid]
		end
	end
	DarkRPG.Server.Player = newPly
	PrintTable(DarkRPG.Server.Player)
	print('test')
end)

-- Player Salary
hook.Add( "playerGetSalary", "DarkRPG_Salary", function( ply , amount ) 
	local darkrpg_pay = math.ceil((DarkRPG.Server.Player[ply:SteamID()].salary or 1)*amount) or amount or 45
	return false, "Payday! You have received $"..darkrpg_pay.."! (+DarkRPG)", darkrpg_pay
end)

local arrestCheck = false
hook.Add("playerArrested", "DarkRPG_Prison", function( ply , timer , cop ) 
	if ply:IsValid() and ply:IsPlayer() and isnumber(timer) and cop:IsValid() and cop:IsPlayer() then
		if !arrestCheck then
			arrestCheck = true
			local hardtime = timer - DarkRPG.Server.Player[ply:SteamID()].prison
			if hardtime <= 0 then 
				DarkRP.notify(ply, 1, 4, "You have been released, you have diplomatic immunity. (+DarkRPG)") 
				DarkRP.notify(cop, 1, 4, "You cannot arrest this player, they have diplomatic immunity. (+DarkRPG)") 
				ply:arrest( 0.1 , cop )
				return true
			end
			ply:arrest( hardtime , cop )
			return true
		else
			arrestCheck = false
		end
	end
end)

hook.Add("UpdatePlayerSpeed", "DarkRPG_movementUpdate", function(ply) 
	if !ply:IsValid() or !ply:IsPlayer() then return end
	ply:SetWalkSpeed( DarkRP.GAMEMODE.Config.walkspeed or 160 )
	ply:SetRunSpeed( DarkRPG.Server.Player[ply:SteamID()] != nil and DarkRPG.Server.Player[ply:SteamID()].movement or DarkRP.GAMEMODE.Config.runspeed or 240 )
	return true
end )

function DarkRPG.buyBonus(ply,price)
	local steamid = ply:SteamID() or nil
	if DarkRPG.Server.Player[steamid] == nil then return end
	price = math.Round((DarkRPG.Server.Player[ply:SteamID()].merchant or 0) * (price or 0)) or price or 0
	ply:addMoney( price )
	return price
end
hook.Add("playerBoughtCustomEntity", "DarkRPG_BuyCustomEnt", function(ply,entTable,ent,price)
	DarkRP.notify(ply, 2, 4, 'You receive a discount worth $'..DarkRPG.buyBonus( ply, price ).." from this purchase. (+DarkRPG)") 
end)
hook.Add("playerBoughtAmmo", "DarkRPG_BuyAmmo", function(ply,entTable,ent,price)
	DarkRP.notify(ply, 2, 4, 'You receive a bulk retail discount worth $'..DarkRPG.buyBonus( ply, price )..". (+DarkRPG)") 
end)
hook.Add("playerBoughtPistol", "DarkRPG_BuyPistol", 	function(ply,entTable,ent,price) 
	DarkRP.notify(ply, 2, 4, 'You receive a military discount worth $'..DarkRPG.buyBonus( ply, price ).." from this purchase. (+DarkRPG)") 
end)
hook.Add("playerBoughtShipment", "DarkRPG_BuyShipment", 	function(ply,entTable,ent,price) 
	DarkRP.notify(ply, 2, 4, 'You receive a bulk retail discount worth $'..DarkRPG.buyBonus( ply, price )..". (+DarkRPG)") 
end)
hook.Add("playerBoughtCustomVehicle", "DarkRPG_BuyVehicle", function(ply,entTable,ent,price) 
	DarkRP.notify(ply, 2, 4, 'You receive a $'..DarkRPG.buyBonus( ply, price ).." refund on your vehicle purchase. (+DarkRPG)") 
end)
hook.Add("onPropertyTax", "DarkRPG_BuyPropTax",	function(ply,tax,couldAfford) 
	DarkRP.notify(ply, 2, 4, 'You receive a $'..DarkRPG.buyBonus( ply, tax ).." property tax rebate. (+DarkRPG)") 
end)
hook.Add("onPaidTax", "DarkRPG_BuyPaidTax", function(ply,tax,wallet) 
	DarkRP.notify(ply, 2, 4, 'You receive a $'..DarkRPG.buyBonus( ply, tax*wallet ).." tax rebate. (+DarkRPG)") 
end)

hook.Add( "InitPostEntity", "DarkRPG_resistCheckTimer", function()
	print('DarkRPG SERVER: Damage Now Activated.')
	function GAMEMODE:EntityTakeDamage(ply,dmg)
		if ply:IsValid() and dmg != nil then

			local atk = dmg:GetAttacker()
			local crit = (atk:IsPlayer() and DarkRPG.Server.Player[atk:SteamID()] != nil and DarkRPG.Server.Player[atk:SteamID()].critical or -1) >= math.random(0,100) and DarkRPG.Server.CritScale or 1
			local atkisply = atk:IsPlayer()

			if atkisply and DarkRPG.Server.Player[atk:SteamID()].damage < 0 then
				ply:SetHealth( math.Clamp( ply:Health() + 100*math.abs(DarkRPG.Server.Player[atk:SteamID()].damage or 1), ply:Health(), ply:GetMaxHealth() ) )
				return true
			elseif ply:IsPlayer() then

				local steamid = DarkRPG.Server.Player[ply:SteamID()]
				if steamid != nil then
					if atkisply or atk:IsNPC() then
						if (steamid.evasion or 0) > 0 and (steamid.evasion or 0) >= math.random(0,100) then 
							ply:EmitSound("weapons/fx/rics/ric"..math.random(1,5)..".wav")
							if atkisply then atk:DarkRPGSendHitNumbers( ply:GetPos(), 0, 2 ) end
							return true
						elseif (steamid.reflect or 0) > 0 and ( atk:IsPlayer() and atk != nil and atk != ply ) and (steamid.reflect or 0) >= math.random(0,100) then
							ply:EmitSound("npc/manhack/grind"..math.random(1,5)..".wav")
							dmg:SetInflictor(atk)
							atk:TakeDamageInfo( dmg )
							if atkisply then atk:DarkRPGSendHitNumbers( ply:GetPos(), dmg:GetDamage(), 3 ) end
							return true
						end
					end

					local dtype = DarkRPG.Resists.List[dmg:GetDamageType()]
					dmg:ScaleDamage( (dtype and (steamid[dtype] or 0) < (steamid.resists or 0) and (steamid[dtype] or 1) or steamid.resists or 1) * (crit or 1) or 1 )
					if atkisply then atk:DarkRPGSendHitNumbers( ply:GetPos(), dmg:GetDamage(), crit > 1 and 1 or 0 ) end
				end
			else
				dmg:ScaleDamage( crit )
				if atkisply then atk:DarkRPGSendHitNumbers( ply:GetPos(), dmg:GetDamage(), crit > 1 and 1 or 0 ) end
			end
		end
	end
end)

util.AddNetworkString("darkrpg_HitNumber")
function meta:DarkRPGSendHitNumbers( target, damage, messageType )
	net.Start("darkrpg_HitNumber")
	net.WriteVector(target)
	net.WriteInt(damage, 14)
	net.WriteInt(messageType,3)
	net.Send(self)
end

function DarkRPG.Server.modifyWeaponPickUp(ply,wpn)
	if wpn.darkrpg_modded then return end -- Stops the weapon from being modded twice and doubling its values.
	local steamid = DarkRPG.Server.Player[ply:SteamID()] -- Stops the function if the steamid is blank
	if steamid == nil then return end

	local wpnClass = wpn:GetClass()
	local wpnCatIdx = DarkRPG.WeaponCategories[wpnClass]
	local wpnCatExists = steamid.weapon != nil and steamid.weapon[wpnCatIdx] != nil
	local wpnCat = wpnCatExists and steamid.weapon[wpnCatIdx] or nil

	local wpnvar = {"Damage", "ClipSize", "DefaultClip", "Delay", "Recoil"}
	local wpnidx = {"damage", "magazine", "magazine", "firerate", "firerate"}

	ply:Give( wpnClass )
	wpn = ply:GetWeapon( wpnClass )

	if wpn.Primary != nil then
		for i = 1, #wpnvar do
			local idx = wpnidx[i]
			local var = wpnvar[i]
			if isnumber(wpn.Primary[var]) and wpn.Primary[var] >= 0 then
				wpn.Primary[var] = math.Clamp( (wpnCatExists and isnumber(wpnCat[idx]) and wpnCat[idx]*wpn.Primary[var]) or (isnumber(steamid[idx]) and steamid[idx]*wpn.Primary[var]) or wpn.Primary[var], 0, 100000 ) or wpn.Primary[var]
				wpn.Primary[var] = var == 'Delay' and math.Clamp(wpn.Primary[var], DarkRPG.Server.MinimumDelay, wpn.Primary[var] ) or wpn.Primary[var]
			end
		end
		if wpn:GetPrimaryAmmoType() != nil then
			ply:GiveAmmo( ( (wpn.Primary.DefaultClip or 0) + (wpn.Primary.ClipSize or 0) ) * (((wpnCatExists and isnumber(wpnCat.ammo) and wpnCat.ammo) or (isnumber(steamid.ammo) and steamid.ammo) or 0)-1), wpn:GetPrimaryAmmoType() )
		end
	end
	if wpn.Secondary != nil then
		for i = 1, #wpnvar do
			local idx = wpnidx[i]
			local var = wpnvar[i]
			if isnumber(wpn.Secondary[var]) and wpn.Secondary[var] >= 0 then
				wpn.Secondary[var] = math.Clamp( (wpnCatExists and isnumber(wpnCat[idx]) and wpnCat[idx]*wpn.Secondary[var]) or (isnumber(steamid[idx]) and steamid[idx]*wpn.Secondary[var]) or wpn.Secondary[var], 0, 100000 ) or wpn.Secondary[var]
				wpn.Secondary[var] = var == 'Delay' and math.Clamp(wpn.Secondary[var], DarkRPG.Server.MinimumDelay, wpn.Secondary[var] ) or wpn.Secondary[var]
			end
		end
		if wpn:GetSecondaryAmmoType() != nil then
			ply:GiveAmmo( ( (wpn.Secondary.DefaultClip or 0) + (wpn.Secondary.ClipSize or 0) ) * (((wpnCatExists and isnumber(wpnCat.ammo) and wpnCat.ammo) or (isnumber(steamid.ammo) and steamid.ammo) or 0)-1), wpn:GetSecondaryAmmoType() )
		end
	end
	wpn.darkrpg_modded = true
end

hook.Add("WeaponEquip", "DarkRPG_weaponEquip", function ( wpn )
	timer.Simple(1, function()
		if wpn:IsValid() and (wpn:GetOwner()):IsValid() and ((wpn:GetOwner()):Alive()) then 
			DarkRPG.Server.modifyWeaponPickUp( wpn:GetOwner(), wpn )
			return 
		end
	end)
end)


function DarkRPG.Server.giveWeapons( ply )
	local steamid = DarkRPG.Server.Player[ply:SteamID()]
	if steamid == nil or steamid.give == nil or steamid.give == {} then return end
	for w, wpn in pairs ( steamid.give ) do
		ply:Give(wpn)
	end
end

function DarkRPG.Server.scanSpawnedWeapons( ply )
	local weapons = ply:GetWeapons()
	for w, wpn in pairs ( weapons ) do
		DarkRPG.Server.modifyWeaponPickUp( ply, wpn )
	end
end

-- String commands do not work in server or table commands :C
function DarkRPG.Server.generateServerSaveId()
	local filename = "drpg_serverinfo.dat"
	if !file.Exists( filename, "DATA" ) then
		local tbl = {}
		for i = 1, 9 do
			table.insert( tbl, math.random(0,9) )
		end

		local id = ''
		for _, t in pairs( tbl ) do
			id = id..t
		end
		file.Write( filename, tonumber(id) )
	else
		file.Open( filename, "r", "DATA" )
		DarkRPG.Server.id = file.Read( filename, "DATA" )
		print( "DarkRPG SERVER: Server Save File Id is '"..DarkRPG.Server.id.."'!" )
	end
end
DarkRPG.Server.generateServerSaveId()

function DarkRPG.Server.addClientSideFiles()
	local drpg_clientfiles = {'core/config_cl','config/config','language/default','core/functions_cl','core/functions_sh','config/weapons','core/frame','config/donator'}
	print("DarkRPG SERVER: Preparing to Send Client files!")
	for _, filename in pairs( drpg_clientfiles ) do
		AddCSLuaFile( "darkrp_modules/darkrpg2/"..filename..".lua" )
	end

	function DarkRPG.createTalent(info)
		resource.AddFile( "materials/darkrpg2/"..info.thumb )
		info = nil
	end

	function DarkRPG.createJobSkills(info)
		info = nil
	end

	DarkRPG.Config = {}
	DarkRPG.GUI = {}
	DarkRPG.Skill = {}
	DarkRPG.Skill.Max = {}

	include( "darkrp_modules/darkrpg2/config/config.lua")

	AddCSLuaFile( "darkrp_modules/darkrpg2/language/"..DarkRPG.Config.Language..".lua" )

	for k, f in pairs( DarkRPG.Config.IncludeJobFiles ) do
		print("DarkRPG SERVER: Sending talent file images --> '"..f..".lua'!")
		AddCSLuaFile( "darkrp_modules/darkrpg2/jobs/"..f..".lua" )
		include( "darkrp_modules/darkrpg2/jobs/"..f..".lua" )
	end

	DarkRPG.Config = nil
	DarkRPG.GUI = nil
	DarkRPG.Skill = nil

	files, directories = file.Find("darkrp_modules/darkrpg2/hud/*", 'lsv')
	for k, f in pairs( files ) do
		AddCSLuaFile( "darkrp_modules/darkrpg2/hud/"..f )
	end

	resource.AddFile( "materials/darkrpg2/x.png" )
end
DarkRPG.Server.addClientSideFiles()
