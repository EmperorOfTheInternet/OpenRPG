function DarkRPG.playerLevelUp( ply , id , old , new )
	if  id == "level" 
	and isnumber(old) 
	and isnumber(new) 
	and old < new 
	and ply:Alive()
	then
		if CLIENT and not SERVER 
		then
			if DarkRPG.Config.PlaySounds and istable(DarkRPG.Config.PlayerLevelUpSound) then
				ply:EmitSound(DarkRPG.Config.PlayerLevelUpSound[1], 100, DarkRPG.Config.PlayerLevelUpSound[2], 0.01*DarkRPG.Config.PlayerLevelUpSound[3])
			end
		else 
			DarkRPG.Server.sendLevelToClient(ply)
		end
	end
end
hook.Add("DarkRPVarChanged","DarkRPG_PlayerLevelUp", DarkRPG.playerLevelUp )

function DarkRPG.createWeaponCategory(info)
	if !istable(info) or !istable(info.weapons) then return end
	DarkRPG.WeaponCategories.maxWpnIndex = (DarkRPG.WeaponCategories.maxWpnIndex or 0) + 1
	local idx = DarkRPG.WeaponCategories.maxWpnIndex
	DarkRPG.WeaponCategories[idx] = info.name
	for w, wpn in pairs ( info.weapons ) do
		DarkRPG.WeaponCategories[wpn] = idx
	end
end