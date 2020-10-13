DarkRPG.error = {}

---------------------------------------------------- CREATION AND VALIDATION FUNCTIONS ----------------------------------------------------

function DarkRPG.createTalent(info)
	info.name = DarkRPG.error.name(info.name)
	info.team = DarkRPG.error.team(info.team)
	info.group = DarkRPG.error.group(info.group)
	if !info.team then return end
	info.stats = DarkRPG.error.stats(info.stats)
	if !DarkRPG.error.pos(info) then return end
	info.ranks = DarkRPG.error.ranks(info.ranks)
	info.weaponcategory = DarkRPG.error.category(info.weaponcategory)
	if !info.stats and !info.weaponcategory and !isstring(info.give) then
		return DarkRPG.error.send("DarkRPG ERROR: '"..info.name.."'' has neither a 'give', a 'stat' or 'weaponcategory' is a valid value. Talent not included.")
	end
	DarkRPG.error.thumb(info.thumb)

	print("DarkRPG: '"..info.name.." has been successfully added.")
	table.insert(DarkRPG.Talent, info)
end

function DarkRPG.createJobSkills(info)
	info.team = DarkRPG.error.team(info.team)
	if !info.team then return end
	info.stats = DarkRPG.error.stats(info.stats)
	if !info.stats then return end
	info.weaponcategory = DarkRPG.error.category(info.weaponcategory)

	table.insert(DarkRPG.Job, info)
end

function DarkRPG.applyUserGroupSettings(info)
	hook.Add("ULibLocalPlayerReady", "DarkRPG_ULXIsGarbage", function() 
	    if info == nil or !istable(info.group) then return end
	    
	    local sppl = DarkRPG.Config.SkillPointsPerLevel or 3
	    local tppl = DarkRPG.Config.TalentPointsPerLevel or 1
	    local msp = DarkRPG.Config.MaximumSkillPoints or 150
	    local mtp = DarkRPG.Config.MaximumTalentPoints or 26

	    for _, grp in pairs( info.group ) do
	        if DarkRPG.vipCheck( {grp} ) then
	            sppl = math.max( sppl, (isnumber(info.SkillsPointsPerLevel) and info.SkillsPointsPerLevel or 0) )
	            tppl = math.max( tppl, (isnumber(info.TalentPointsPerLevel) and info.TalentPointsPerLevel or 0) )
	            msp = math.max( msp, (isnumber(info.MaximumSkillPoints) and info.MaximumSkillPoints or 0) )
	            mtp = math.max( tppl, (isnumber(info.MaximumTalentPoints) and info.MaximumTalentPoints or 0) )
	        end
	    end

	    DarkRPG.Player.Donator = {}
	    DarkRPG.Player.Donator.SPPL = sppl
	    DarkRPG.Player.Donator.TPPL = tppl
	    DarkRPG.Player.Donator.MSP = msp
	    DarkRPG.Player.Donator.MTP = mtp

	    DarkRPG.existsResetMenu(0.5)
    end)
end

function DarkRPG.existsResetMenu(period)
	timer.Simple(period, function()
		if DarkRPG.reset == nil then DarkRPG.existsResetMenu(period) return end
		DarkRPG.setResetButtonText(true)
		DarkRPG.updateAddSubButtons()
	end)
end

function DarkRPG.error.thumb(thumb)
	resource.AddFile( "materials/darkrpg2/"..thumb  )
end
resource.AddFile( "materials/darkrpg2/x.png"  )
resource.AddFile( "materials/hud/killicons/darkrpgDarkRPG.vtf"  )
resource.AddFile( "materials/hud/killicons/darkrpgDarkRPG.vmt"  )

function DarkRPG.error.send(message)
	if !DarkRPG.Config.DisplayErrors then return end
	print(message)
	local err = debug.traceback()
	if istable(err) then PrintTable(err) else print(err) end
	return false
end

function DarkRPG.error.name(name)
	if isstring(name) then return name end
	DarkRPG.error.send( "DarkRPG Warning: Your talent name is either blank, not a string, a {table}, or you mispelled 'name:' in the .lua file, defaulting title name to 'Untitled Talent'. Printing out the location of the file error." )
	return "Untitled Talent"
end

function DarkRPG.error.team(team)
	if team == nil then return DarkRPG.error.send('DarkRPG ERROR: You are missing the team property in your talent, nobody can use this talent. Talent not included.') end
	if !istable(team) then team = { team } end
	for _, t in pairs( team ) do
		if !isnumber(t) then 
			return DarkRPG.error.send('DarkRPG ERROR: Your job in your talent is an invalid value, the job either does not exist on your server, or mispelled in the config folder. Talent not included.')
		end
	end
	return team
end

function DarkRPG.error.group(group)
	if group == nil then return nil end
	if !istable(group) then group = { group } end
	for _, g in pairs( group ) do
		if !isstring(g) then 
			DarkRPG.error.send('DarkRPG Warning: Your group in your talent has an invalid value, the vip group table must contain strings. VIP on this talent has been deleted.')
			return nil
		end
	end
	return group
end

function DarkRPG.error.pos(info)
	if !istable(info.pos) or !isnumber(info.pos[1]) or !isnumber(info.pos[2]) or info.pos[1] < 1 or info.pos[2] < 1 then 
		return DarkRPG.error.send("DarkRPG ERROR: Your talent '"..info.name.."' -- 'pos' value is blank, not a {table} with number values, those values are 0, a negative number or you mispelled 'pos:'. Talent has NOT been included. Printing out the location of the file error.")
	end
	info.pos = { tonumber(info.pos[1]), tonumber(info.pos[2]) }
	if info.pos[1] > DarkRPG.Config.TalentWidth then
		return DarkRPG.error.send("DarkRPG ERROR: Your talent '"..info.name.."' -- will not be added because the x position of this talent is wider than the TalentWidth value on the server, to fix this lower the first pos value 'pos = {value1, value2}' <-- that first one, or increase 'DarkRPG.Config.TalentWidth' to "..info.pos[1]..". Talent has NOT been included. Printing out the location of the file error.")
	end
	info.level = math.ceil( (info.pos[2]-1) * DarkRPG.Config.NextTierMinimum )
	info.pos = math.ceil( (info.pos[2]-1) * DarkRPG.Config.TalentWidth+info.pos[1] )
	if info.level > DarkRPG.Config.MaximumTalentPoints then
		return DarkRPG.error.send("DarkRPG ERROR: Your talent '"..info.name.."' -- will not be added because the level requirement is higher than the allowed number of talent points on the server, to fix this lower the second pos value 'pos = {value1, value2}' <-- that second one, or increase 'DarkRPG.Config.MaximumTalentPoints' to "..info.level..". Talent has NOT been included. Printing out the location of the file error.")
	end
	return info
end

function DarkRPG.error.ranks(ranks)
	if ranks != nil and !isnumber(ranks) then
		DarkRPG.error.send("DarkRPG Warning: Your talent has a 'ranks' value, but it is not a number so this talent will have no ranks.")
		return nil
	end
	ranks = math.ceil(tonumber(ranks or 0))
	if ranks > 9 then 
		DarkRPG.error.send( "DarkRPG Warning: Your talent has a 'ranks' value which is above 9 and will be reduced to only 9 ranks." )
		return 9
	end
	return ranks
end

function DarkRPG.error.stats(stats)
	if !istable(stats) then return nil end
	for name, value in pairs( stats ) do
		stats[name] = tonumber( string.Replace( value, "%", "" ) )
		if( stats[name] == nil ) then
			return DarkRPG.error.send("DarkRPG ERROR: One of the stat values has an invalid character, it must include a number or a % sign. Talent not included.")
		end
	end
	return stats
end

function DarkRPG.error.category(weaponcategory)
	if !istable(weaponcategory) or !isstring(weaponcategory.name) then return nil end
	for w = 1, DarkRPG.WeaponCategories.maxWpnIndex do
		if weaponcategory.name == DarkRPG.WeaponCategories[w] then 
			weaponcategory.stats = DarkRPG.error.stats( weaponcategory.stats )
			return weaponcategory
		end
	end
	DarkRPG.error.send( "DarkRPG Warning: Your weapon category name does not exist or is mispelled, check 'config/weapons.lua' to see if the category exists/both names match. Weapon Category bonus removed from Talent." )
	return nil
end

function DarkRPG.getMaxSkillPoints()
	return DarkRPG.Config.NoLevelingMode and DarkRPG.Config.MaximumSkillPoints or math.Clamp( math.floor(DarkRPG.Player.level*(DarkRPG.Player.Donator.SPPL or DarkRPG.Config.SkillPointsPerLevel)), 0, (DarkRPG.Player.Donator.MSP or DarkRPG.Config.MaximumSkillPoints) )
end

function DarkRPG.getMaxTalentPoints()
	return math.Clamp( math.floor(DarkRPG.Player.level*(DarkRPG.Player.Donator.TPPL or DarkRPG.Config.TalentPointsPerLevel)), 0, (DarkRPG.Player.Donator.MTP or DarkRPG.Config.MaximumTalentPoints) )
end

function DarkRPG.returnJobTableTeam()
	return istable(LocalPlayer():getJobTable()) and (LocalPlayer():getJobTable()).team or 1
end

function DarkRPG.addTalentsToPlayer()
	--checks the TEAM_JOB numbers of the talent and the player and determines if .team is the same and therefore can be used by the player
	local plyjob = DarkRPG.returnJobTableTeam()
	DarkRPG.Player.Talents = {}
	DarkRPG.Save[plyjob] = DarkRPG.Save[plyjob] or {}
	DarkRPG.Save[plyjob].TP = DarkRPG.Save[plyjob].TP or {} --fix
	DarkRPG.Player.talentTreeSize = 0

	local stoploop
	for k, v in pairs( DarkRPG.Talent ) do
		stoploop = false
		for l, w in pairs( v.team ) do
			if plyjob == w and !stoploop then
				stoploop = true -- if a talent has TWO of the same TEAM_ jobs in it, this ignores it by adding a duplicate talent
				table.insert(DarkRPG.Player.Talents, v)
				DarkRPG.Player.talentTreeSize = math.max(DarkRPG.Player.talentTreeSize, v.pos)
			end
		end
	end

	local duplicateCheck = {}
	for k, pt in pairs( DarkRPG.Player.Talents ) do
		if duplicateCheck[pt.pos] != nil then
			DarkRPG.error.send("DarkRPG ERROR: Duplicate Talent detected for this player job, two or more talents have the same .pos value and will overlap with this job. Printing the objects, search your talent files for these.")
		else
			duplicateCheck[pt.pos] = pt
		end
	end
	DarkRPG.Player.Talents = {}
	DarkRPG.Player.Talents = duplicateCheck
end

function DarkRPG.addJobToPlayer()
	local plyjob = DarkRPG.returnJobTableTeam()
	DarkRPG.Player.Job = {}
	DarkRPG.Save[plyjob] = {}
	DarkRPG.Save[plyjob].SP = {}

	for j, jlist in pairs( DarkRPG.Job ) do
		if table.HasValue( jlist.team, plyjob ) then
			DarkRPG.Player.Job = jlist
			DarkRPG.convertJobToStats()
			return
		end
	end
	DarkRPG.convertJobToStats()
end

---------------------------------------------------- CREATION AND VALIDATION FUNCTIONS ----------------------------------------------------

---------------------------------------------------- CONVERT FUNCTIONS ----------------------------------------------------

function DarkRPG.convertTalentToStats(talent)
	if talent.stats != nil then
		for k, n in pairs( DarkRPG.GUI.Stat_VarNames ) do
			if talent.stats[n] != nil then
				DarkRPG.Player.Stats[n].talent = tonumber(DarkRPG.Player.Stats[n].talent or 0) + talent.stats[n]*0.01
				DarkRPG.convertStatsToTotal(n)
			end
		end
	end
	DarkRPG.convertGiveToStats(talent.give)
	DarkRPG.convertWeaponCategoryToStats(talent.weaponcategory)
	--DarkRPG.convertFunctionToStats(talent.custom)
end

function DarkRPG.convertGiveToStats(give)
	if !isstring(give) then return end

	DarkRPG.Player.Give = DarkRPG.Player.Give or {}
	if table.HasValue( DarkRPG.Player.Give, give ) then return end

	table.insert(DarkRPG.Player.Give, give)
end

function DarkRPG.convertWeaponCategoryToStats(wc)
	if !istable(wc) then return end
	if !isstring(wc.name) or !istable(wc.stats) then return end
	local wpncatid
	for wpnid, w in ipairs( DarkRPG.WeaponCategories ) do
		if w == wc.name then
			wpncatid = wpnid
		end
	end
	if !isnumber(wpncatid) then return end

	DarkRPG.Player.Weapon = DarkRPG.Player.Weapon or {}
	DarkRPG.Player.Weapon[wpncatid] = DarkRPG.Player.Weapon[wpncatid] or {}

	for k, n in pairs( DarkRPG.GUI.Stat_WeaponNames ) do
		if wc.stats[n] != nil then
			DarkRPG.Player.Weapon[wpncatid][n] = math.Clamp( (DarkRPG.Player.Weapon[wpncatid][n] or 0) + tonumber(wc.stats[n] or 0)*0.01, 0, DarkRPG.Skill.Max[n] )
		end
	end
end

function DarkRPG.convertSkillToStats(label, isSubtractButton)
	local name = string.lower(label)
	local plyjob = DarkRPG.returnJobTableTeam()
	DarkRPG.Player.Stats[name].total = DarkRPG.Player.Stats[name].total or 0
	if DarkRPG.Player.Stats[name].total >= DarkRPG.Skill.Max[name] then return end
	DarkRPG.Player.Stats[name].skill = math.Round( (DarkRPG.Player.Stats[name].skill or 0) + (isSubtractButton and -DarkRPG.Skill[name] or DarkRPG.Skill[name]) , 4)
	DarkRPG.Player.spentSkills = (DarkRPG.Player.spentSkills or 0) + (isSubtractButton and -1 or 1)
	DarkRPG.convertStatsToTotal(name)
	if isSubtractButton then
		DarkRPG.Save[plyjob].SP[label] = (DarkRPG.Save[plyjob].SP[label] or 1) - 1
		DarkRPG.updateSubButton(label)
		return
	end
	DarkRPG.Save[plyjob] = DarkRPG.Save[plyjob] or {}
	DarkRPG.Save[plyjob].SP = DarkRPG.Save[plyjob].SP or {}
	DarkRPG.Save[plyjob].SP[label] = (DarkRPG.Save[plyjob].SP[label] or 0) + 1
	DarkRPG.updateAddButton(label)
end

function DarkRPG.convertJobToStats()
	DarkRPG.Player.Job.stats = DarkRPG.Player.Job.stats or {}
	for k, n in pairs( DarkRPG.GUI.Stat_VarNames ) do
		DarkRPG.Player.Stats[n].job = math.Round((DarkRPG.Player.Job.stats[n] or 0)*0.01 , 4 ) or 0
		DarkRPG.convertStatsToTotal(n)
	end
	DarkRPG.convertWeaponCategoryToStats(DarkRPG.Player.Job.weaponcategory)
end

function DarkRPG.convertConfigToStats()
	for k, n in pairs( DarkRPG.GUI.Stat_VarNames ) do
		DarkRPG.Skill.Max[n] = tonumber( string.Replace( (""..DarkRPG.Skill.Max[n]), "%", "" ) )
		DarkRPG.Skill.Max[n] = math.Round( DarkRPG.Skill.Max[n]*0.01 , 4 )
		DarkRPG.Skill[n] = tonumber( string.Replace( (""..DarkRPG.Skill[n]), "%", "" ) )
		DarkRPG.Skill[n] = math.Round( DarkRPG.Skill[n]*0.01 , 4 )
	end
end

function DarkRPG.convertStatsToTotal(name)
	local s = DarkRPG.Player.Stats[name]
	DarkRPG.Player.Stats[name].total = math.Clamp( (s.job or 0) + (s.skill or 0) + (s.talent or 0), DarkRPG.Skill.Min[name], DarkRPG.Skill.Max[name] )
end

---------------------------------------------------- CONVERT FUNCTIONS ----------------------------------------------------

---------------------------------------------------- RESET FUNCTIONS ----------------------------------------------------

function DarkRPG.resetPlayerStats()
	DarkRPG.Player.Stats = {}
	DarkRPG.Player.Give = {}
	DarkRPG.Player.Weapon = {}
	for k, n in pairs( DarkRPG.GUI.Stat_VarNames ) do
		DarkRPG.Player.Stats[n] = {}
	end

	DarkRPG.addJobToPlayer()
	DarkRPG.addTalentsToPlayer()
end

function DarkRPG.resetTalentPoints()
	for k, n in pairs( DarkRPG.GUI.Stat_VarNames ) do
		DarkRPG.Player.Stats[n].talent = nil
	end
	DarkRPG.Player.spentTalents = 0

	for k, v in pairs( DarkRPG.Player.Talents ) do
		v.spent = 0
	end

	DarkRPG.Save[DarkRPG.returnJobTableTeam()].TP = {}

	for k, v in pairs( DarkRPG.tree.talent ) do
		if v.button != nil then
			v.button:SetDisabled(false)
		end
		for k, z in pairs( DarkRPG.Player.Talents ) do
			if DarkRPG.tree.talent[z.pos].ranks != nil and z.ranks != nil then 
				DarkRPG.tree.talent[z.pos].ranks:SetText(" 0/"..z.ranks)
			end
		end
	end

	DarkRPG.Player.Give = {}
	DarkRPG.Player.Weapon = {}

	DarkRPG.setResetButtonText(true)
end

function DarkRPG.resetSkillPoints()
	local plyjob = DarkRPG.returnJobTableTeam()
	DarkRPG.Save[plyjob] = DarkRPG.Save[plyjob] or {}
	DarkRPG.Save[plyjob].SP = DarkRPG.Save[plyjob].SP or {}

	for k, n in pairs( DarkRPG.GUI.Stat_VarNames ) do
		DarkRPG.Player.Stats[n].skill = nil
	end
	for k, l in pairs( DarkRPG.GUI.Stat_Labels ) do
		DarkRPG.Save[plyjob].SP[l] = nil
	end
	DarkRPG.Player.spentSkills = 0
	DarkRPG.setResetButtonText(true)
	DarkRPG.updateAddSubButtons()
end

---------------------------------------------------- RESET FUNCTIONS ----------------------------------------------------

----------------------------------------------- UPDATING AND TEXT PARSING -----------------------------------------------

function DarkRPG.updateUsedPoints()
	if DarkRPG.tree:IsVisible() then 
		DarkRPG.points:SetText( "Points: "..(DarkRPG.getMaxTalentPoints()-DarkRPG.Player.spentTalents) )
	else
		if DarkRPG.Config.SkillPointsOn then 
			DarkRPG.points:SetText( "Points: "..(DarkRPG.getMaxSkillPoints()-DarkRPG.Player.spentSkills) )
		else
			DarkRPG.points:SetText( "Points: --" )
		end
	end
	DarkRPG.points:SizeToContents()
end

function DarkRPG.updateTalentBox(talent)
	local v = talent
	if v.spent == nil then v.spent = 0 end
	local plyjob = DarkRPG.returnJobTableTeam()
	DarkRPG.Save[plyjob] = DarkRPG.Save[plyjob] or {}

	if (DarkRPG.getMaxTalentPoints()-DarkRPG.Player.spentTalents) < 1 then return end -- the player must have at least 1 unspent talent points
	if DarkRPG.tree.talent[v.pos].button:GetDisabled() == true then return end -- the talent button must not be disabled
	--if DarkRPG.Player.level < v.level then return end -- player must be minimum level
	if DarkRPG.Player.spentTalents < v.level then return end -- player must have x talents invested in lower tiers
	if v.group and !DarkRPG.vipCheck(v.group) then return end -- vip check
	if DarkRPG.Save[plyjob].TP == nil then DarkRPG.Save[plyjob].TP = {} end

	if (v.ranks == nil or v.ranks < 2) and v.spent == 0 then
		DarkRPG.Player.spentTalents = DarkRPG.Player.spentTalents + 1
		DarkRPG.updateUsedPoints()
		v.spent = 1
		DarkRPG.Save[plyjob].TP[v.pos] = v.spent
		DarkRPG.tree.talent[v.pos].button:SetDisabled(true)
		DarkRPG.convertTalentToStats(v)
	elseif v.ranks != nil and v.ranks > 1 and v.ranks > v.spent then
		DarkRPG.Player.spentTalents = DarkRPG.Player.spentTalents + 1
		DarkRPG.updateUsedPoints()
		v.spent = v.spent + 1
		DarkRPG.Save[plyjob].TP[v.pos] = v.spent
		DarkRPG.tree.talent[v.pos].ranks:SetText(" "..v.spent.."/"..v.ranks)
		if v.ranks == v.spent then
			DarkRPG.tree.talent[v.pos].button:SetDisabled(true)
		end
		DarkRPG.convertTalentToStats(v)
	end 
	if (DarkRPG.getMaxTalentPoints()-DarkRPG.Player.spentTalents) < 1 then 
		DarkRPG.setResetButtonText()
	end
end

function DarkRPG.updateBoxStatAll()
	for k, n in pairs( DarkRPG.GUI.Stat_VarNames ) do
		DarkRPG.convertStatsToTotal(n)
	end
	for k, l in pairs( DarkRPG.GUI.Stat_Labels ) do
		DarkRPG.updateBoxStat(l)
	end
end

function DarkRPG.updateBoxStat(label)
	local stat = DarkRPG.Player.Stats[string.lower(label)]
	local name = string.lower(label)
	
	if label == "Health" or label == "Armor" then
		DarkRPG.stat.box[label].value:SetText( (isnumber(stat.total) and stat.total > 0 and "+" or '')..( (DarkRPG.Skill[label] or 0) + (stat.total*100) ) or 'NIL')
	elseif label == "Resists" then
		stat = {}
		for k, v in pairs( DarkRPG.GUI.Stat_ResistNames ) do
			stat[k] = DarkRPG.Player.Stats[v]
			stat[k] = ((stat[k].job or 0) + (stat[k].talent or 0) + (stat[k].skill or 0))*100
		end
		DarkRPG.stat.box[label].value:SetText( (isnumber(stat.total) and stat.total > 0 and "+" or '')..(math.max(stat[1], stat[2], stat[3], stat[4], stat[5])).."%" or 'NIL')
	else
		DarkRPG.stat.box[label].value:SetText( (isnumber(stat.total) and stat.total > 0 and "+" or '')..(stat.total*100).."%" or 'NIL')
	end

	DarkRPG.stat.box[label].value:SizeToContents()
	DarkRPG.stat.box[label].value:Center()
	DarkRPG.stat.box[label].value:SetPos(DarkRPG.stat.box[label].value.x, DarkRPG.stat.box[label].value.y - 8)

	local txtclr = 1 / DarkRPG.Skill.Max[name] * DarkRPG.Player.Stats[name].total
	if txtclr < 0 then
		DarkRPG.stat.box[label].value:SetTextColor( DarkRPG.GUI.Color.Stat_Txt_Bad or Color( 229, 42, 42 ) )
	elseif txtclr <= 0.1 then
		DarkRPG.stat.box[label].value:SetTextColor( DarkRPG.GUI.Color.Stat_Txt_Normal or Color( 252, 252, 252 ) )
	elseif txtclr <= 0.35 then
		DarkRPG.stat.box[label].value:SetTextColor( DarkRPG.GUI.Color.Stat_Txt_Good or Color( 99, 229, 77 ) )
	elseif txtclr < 0.75 then
		DarkRPG.stat.box[label].value:SetTextColor( DarkRPG.GUI.Color.Stat_Txt_Great or Color( 77, 163, 229 ) )
	elseif txtclr < 1 then
		DarkRPG.stat.box[label].value:SetTextColor( DarkRPG.GUI.Color.Stat_Txt_Epic or Color( 193, 120, 226 ) )
	else
		DarkRPG.stat.box[label].value:SetTextColor( DarkRPG.GUI.Color.Stat_Txt_Max or Color( 204, 182, 105 ) )
	end
end

function DarkRPG.setResetButtonText(isReset)
	if isReset then
		DarkRPG.reset:SetText( DarkRPG.GUI.Footer_Reset_Text )
	else
		DarkRPG.reset:SetText( DarkRPG.GUI.Footer_Confirm_Text )
	end
	
	DarkRPG.reset:SizeToContents()
	DarkRPG.reset:SetPos( DarkRPG.frame:GetWide() - DarkRPG.reset:GetWide() - DarkRPG.GUI.Title_Padding, (DarkRPG.GUI.Title_Height-DarkRPG.reset:GetTall())/2-2 )
	DarkRPG.updateUsedPoints()
	DarkRPG.updateBoxStatAll()
end

function DarkRPG.updateResetButtonSwitch()
	if DarkRPG.stat:IsVisible() then
		if DarkRPG.Config.SkillPointsOn then 
			DarkRPG.reset:SetVisible(true)
			DarkRPG.points:SetVisible(true)
		else 
			DarkRPG.reset:SetVisible(false) 
			DarkRPG.points:SetVisible(false)
		end
		if (DarkRPG.getMaxTalentPoints()-DarkRPG.Player.spentTalents) < 1 then 
			DarkRPG.setResetButtonText()
			return
		end
		DarkRPG.setResetButtonText(true)
		return
	elseif DarkRPG.tree:IsVisible() then
		if DarkRPG.Config.TalentPointsOn then 
			DarkRPG.reset:SetVisible(true)
			DarkRPG.points:SetVisible(true) 
		end
		if DarkRPG.Player.spentSkills >= DarkRPG.getMaxSkillPoints() then
			DarkRPG.setResetButtonText()
			return
		end
		DarkRPG.setResetButtonText(true)
		return
	end
	DarkRPG.reset:SetVisible(false) 
	DarkRPG.points:SetVisible(false)
end

function DarkRPG.updateResetButton()
	if DarkRPG.reset:GetText() == DarkRPG.GUI.Footer_Confirm_Text then
		if DarkRPG.shouldStopConfirm() then return end
		DarkRPG.sendPlayerTotalsToServer()
		DarkRPG.setResetButtonText(true)
		DarkRPG.savePlayerSettings()
		if DarkRPG.stat:IsVisible() then 
			DarkRPG.disableAddSubButtons()
		end
		return
	end
	if DarkRPG.stat:IsVisible() then 
		DarkRPG.resetSkillPoints()
		return
	end
	DarkRPG.resetTalentPoints()	
end

function DarkRPG.shouldStopConfirm()
	if DarkRPG.Config.DelayToReset <= 0 then return false end
	DarkRPG.reset.stopConfirm = DarkRPG.reset.stopConfirm or false
	if DarkRPG.reset.stopConfirm then
		LocalPlayer():ChatPrint('You must wait '..math.Round(timer.TimeLeft('DarkRPG_stopSpammingServer')+1)..' seconds before saving your stats/talents to server.' )
		return true
	end
	DarkRPG.reset.stopConfirm = true
	timer.Create( 'DarkRPG_stopSpammingServer', DarkRPG.Config.DelayToReset, 1, function()
		if menu == nil or DarkRPG.reset == nil then return end
		DarkRPG.reset.stopConfirm = false
		timer.Remove('DarkRPG_stopSpammingServer')
	end)
	return false
end

function DarkRPG.updateHelpMenu()
	local text = 'Server Settings:\n'
	text = text..(DarkRPG.Config.TalentPointsOn and '\nTalents Points activated.' or '\nTalent Points are turned off.')
	text = text..(DarkRPG.Config.SkillPointsOn and '\nSkill Points activated.' or '\nSkill Points are turned off.')
	text = text..(DarkRPG.Config.NoLevelingMode and '\nNo Leveling Mode is on.' or '\nNo Leveling Mode is off.')
	text = text..'\nSkill Points Per Level: '..DarkRPG.Config.SkillPointsPerLevel
	text = text..'\nTalent Points Per Level: '..DarkRPG.Config.TalentPointsPerLevel
	text = text..'\nMaximum Talent Points: '..DarkRPG.Config.MaximumTalentPoints
	text = text..'\nTalent Points Per Tier: '..DarkRPG.Config.NextTierMinimum
	text = text..(DarkRPG.Config.HitNumbers and '\nHit Numbers activated.' or '\nHit Numbers is off.')
	text = text..'\nHUD Style: '..DarkRPG.Config.HUDStyle
	text = text.."\n\nYou are now using DarkRPG2: a fully customizable Garry's Mod engine that adds skills and talent trees to DarkRP created by Emperor of the Internet! Can be obtained at Script Fodder."
	
	text = text.."\n\nPro Tips!:"
	text = text.."\n - Press F2 to quick turn on the HUD and press X to turn it off!"
	text = text.."\n - Press Confirm, otherwise your settings won't be saved!"
	text = text.."\n - Your talent/skill settings are saved for EACH job!"
	DarkRPG.help.info:SetText( string.wrapwords(text,DarkRPG.GUI.Font.Tooltip_Info, DarkRPG.frame:GetWide()-48 ) )
	DarkRPG.help.info:SizeToContents()
end

function DarkRPG.updateTooltip( panel, info )
	if panel:GetName() != DarkRPG.tooltip.currentHovered and (panel:IsChildHovered() or panel:IsHovered()) then
		DarkRPG.tooltip.currentHovered = panel:GetName() -- only paints tooltip once
		
		if !DarkRPG.tooltip:IsVisible() then DarkRPG.tooltip:SetVisible(true) end

		DarkRPG.playSound(DarkRPG.Config.StatTalentHoverSound)

		function DarkRPG.tooltip:Paint( w, h )
			DarkRPG.tooltip:SetPos( math.Clamp( gui.MouseX()+2 , 0 , surface.ScreenWidth() - DarkRPG.tooltip:GetWide() ), math.Clamp( gui.MouseY()+2 , 0 , surface.ScreenHeight() - DarkRPG.tooltip:GetTall() ) )
			
			if !DarkRPG.tooltip.stopDisplay and panel != nil and (panel:IsChildHovered() or panel:IsHovered()) then
				DarkRPG.tooltip.title:SetVisible(true)
				DarkRPG.tooltip.desc:SetVisible(true)
				DarkRPG.tooltip.effect:SetVisible(true)
				draw.RoundedBoxEx( DarkRPG.GUI.Corner or 8, 0, 0, w, h, DarkRPG.GUI.Color.Tooltip_BG or Color( 34, 37, 42 ), false, true, true, true )
				return
			end
			DarkRPG.tooltip.title:SetVisible(false)
			DarkRPG.tooltip.desc:SetVisible(false)
			DarkRPG.tooltip.effect:SetVisible(false)
		end

		if DarkRPG.tree:IsVisible() then 
			DarkRPG.updateTooltipTalentBox(info)
			return
		end

		DarkRPG.updateTooltipStatBox(panel) -- WORK ON NEXT, USE TOOLTIP TALENT AS BASE, MAKE LABEL DIALOGUE FOR THE SKILLS
	end
end

function DarkRPG.updateTooltipStatBox( panel )
	local name = string.lower( panel:GetName() )
	local desc = (DarkRPG.GUI.Tooltip.Desc[name] or "Someone touched or deleted DarkRPG.GUI.Tooltip.Desc didn't they? >:C")
	local effect = DarkRPG.GUI.Tooltip.Desc.modifiers
	if name == "resists" then
		effect = effect..DarkRPG.GUI.Tooltip.Desc.resistInfo
		local title = {DarkRPG.GUI.Tooltip.Desc.resistAllDamage, DarkRPG.GUI.Tooltip.Desc.resistFireDamage, DarkRPG.GUI.Tooltip.Desc.resistPoisonDrown, DarkRPG.GUI.Tooltip.Desc.resistCrushFall, DarkRPG.GUI.Tooltip.Desc.resistExplosives}
		for k, rn in pairs( DarkRPG.GUI.Stat_ResistNames ) do
			effect = effect.."\n"..title[k]..DarkRPG.GUI.Tooltip.Desc.colon..(((DarkRPG.Player.Stats[rn].job or 0) + (DarkRPG.Player.Stats[rn].talent or 0) + (DarkRPG.Player.Stats[rn].skill or 0))*100)..DarkRPG.GUI.Tooltip.Desc.percent
			effect = effect.." ( "..((DarkRPG.Player.Stats[rn].job or 0)*100).."/"
			effect = effect..((DarkRPG.Player.Stats[rn].talent or 0)*100).."/"
			effect = effect..((DarkRPG.Player.Stats[rn].skill or 0)*100).." )"
			effect = effect.." [ +"..(DarkRPG.Skill.Max[rn]*100).."% ]"
		end
	else
		local percent = (name == 'health' or name == 'armor') and DarkRPG.GUI.Tooltip.Desc.points..DarkRPG.GUI.Tooltip.Desc.period or DarkRPG.GUI.Tooltip.Desc.percent..DarkRPG.GUI.Tooltip.Desc.period
		effect = effect..'\n'..DarkRPG.GUI.Tooltip.Desc.playerJob..((DarkRPG.Player.Stats[name].job or 0) >= 0 and DarkRPG.GUI.Tooltip.Desc.plussign or '')..((DarkRPG.Player.Stats[name].job or 0)*100)..percent
		if DarkRPG.Player.Stats[name].talent != nil then
			effect = effect..'\n'..DarkRPG.GUI.Tooltip.Desc.talents..((DarkRPG.Player.Stats[name].talent) >= 0 and DarkRPG.GUI.Tooltip.Desc.plussign or '')..(DarkRPG.Player.Stats[name].talent*100)..percent
		end
		if DarkRPG.Player.Stats[name].skill != nil then
			effect = effect..'\n'..DarkRPG.GUI.Tooltip.Desc.skills..((DarkRPG.Player.Stats[name].skill) >= 0 and DarkRPG.GUI.Tooltip.Desc.plussign or '')..(DarkRPG.Player.Stats[name].skill*100)..percent
		end
		if DarkRPG.Player.Weapon != nil then
			for w, wpn in pairs( DarkRPG.Player.Weapon ) do
				if wpn[name] != nil then
					effect = effect.."\n"..DarkRPG.WeaponCategories[w]..DarkRPG.GUI.Tooltip.Desc.colon..((wpn[name] or 0) >= 0 and  DarkRPG.GUI.Tooltip.Desc.plussign or '')..(wpn[name]*100)..percent
				end
			end
		end
		desc = desc.."\n"..DarkRPG.GUI.Tooltip.Desc.serverSide..((DarkRPG.Skill.Max[name] or 0)*100)..percent
	end
	DarkRPG.updateTooltipText( DarkRPG.GUI.Tooltip.Desc[panel:GetName()] or panel:GetName(), desc, effect ) 
	DarkRPG.tooltip.effect:SetTextColor( DarkRPG.GUI.Color.Tooltip_Effect or Color( 46, 166, 48 ) )
end

function DarkRPG.updateTooltipTalentBox(info)
	if info == nil then return end

	local name = info.name or DarkRPG.GUI.Tooltip.Desc.talentNameError -- Name of the talent or 'Untitled Talent'

	local desc = info.desc or '' -- Use custom description or generate one automatically.
	if !info.desc then
		for k, v in pairs( DarkRPG.GUI.Stat_VarNames ) do
			desc = DarkRPG.parseTooltipTalentText(desc,info.stats,v) or '' -- adds the increases and decreases text general stats
		end
		if info.weaponcategory != nil and info.weaponcategory.stats != nil then
			for wn, wname in pairs( DarkRPG.GUI.Stat_WeaponNames ) do
				desc = DarkRPG.parseTooltipTalentText(desc,info.weaponcategory.stats,wname,info.weaponcategory.name) or '' -- adds the increases and decreases text for weapons
			end
		end
		desc = isstring(info.give) and desc.."@"..DarkRPG.GUI.Tooltip.Desc.givesYou..info.give..DarkRPG.GUI.Tooltip.Desc.onPlayerSpawn or desc or '' -- '@gives you a m9k_gun on player spawn' or ''
		desc = string.Explode("@", desc) -- split by @ symbols into table
		desc[#desc] = #desc > 1 and DarkRPG.GUI.Tooltip.Desc.linkand..desc[#desc] or desc[#desc] -- add ' and ' to end of sentence 
		desc = string.Implode( DarkRPG.GUI.Tooltip.Desc.linkcomma, desc) -- implode and replace all @ signs with ', '
		desc = info.ranks != nil and info.ranks > 1 and info.name.." "..desc..DarkRPG.GUI.Tooltip.Desc.perRank..DarkRPG.GUI.Tooltip.Desc.period or info.name.." "..desc..DarkRPG.GUI.Tooltip.Desc.period -- NameOfTalent..Description..' per rank.'
	end

	local effect = ''
	DarkRPG.tooltip.effect:SetTextColor( DarkRPG.GUI.Color.Tooltip_Effect_Lock or Color( 226, 112, 116 ) )
	if info.group and !DarkRPG.vipCheck( info.group ) then
		if info.level > DarkRPG.Player.spentTalents then
			effect = DarkRPG.parseTooltipTalentTextVIP(info.group)..DarkRPG.GUI.Tooltip.Desc.linkand..(info.level-DarkRPG.Player.spentTalents)..DarkRPG.GUI.Tooltip.Desc.pointsToUnlock..DarkRPG.GUI.Tooltip.Desc.period
		else
			effect = DarkRPG.parseTooltipTalentTextVIP(info.group)..DarkRPG.GUI.Tooltip.Desc.period
		end
	else
		if info.level > DarkRPG.Player.spentTalents then
			effect = DarkRPG.GUI.Tooltip.Desc.requiresPrefix..(info.level-DarkRPG.Player.spentTalents)..DarkRPG.GUI.Tooltip.Desc.pointsToUnlock..DarkRPG.GUI.Tooltip.Desc.period
		else
			effect = DarkRPG.GUI.Tooltip.Desc.talentUnlocked
			DarkRPG.tooltip.effect:SetTextColor( DarkRPG.GUI.Color.Tooltip_Effect or Color( 46, 166, 48 ) )
		end
	end
	DarkRPG.updateTooltipText( name, desc, effect )
end

function DarkRPG.parseTooltipTalentTextVIP(group)
	local effect = '' 
	effect = effect..DarkRPG.GUI.Tooltip.Desc.mustBeInVIP
	for i, grp in pairs(group) do
		effect = effect.."'"..grp.."'"..(#group != i and "@" or "") or effect
	end
	effect = string.Explode("@", effect)
	effect[#effect] = #effect > 1 and DarkRPG.GUI.Tooltip.Desc.linkor..effect[#effect] or effect[#effect]
	return string.Implode( DarkRPG.GUI.Tooltip.Desc.linkcomma, effect)
end

function DarkRPG.parseTooltipTalentText(desc,stat,id,category)
	if stat == nil then return end
	if stat[id] == nil then return desc end
	desc = desc or ''
	if desc != '' then desc = desc..'@' end
	if id == 'health' or id == 'armor' then
		if stat[id] > 0 then
			return desc..DarkRPG.GUI.Tooltip.Desc.increases..DarkRPG.GUI.Tooltip[id]..DarkRPG.GUI.Tooltip.Desc.by..stat[id]..DarkRPG.GUI.Tooltip.Desc.points -- '@increases [Health] by [25] points'
		end
		return desc..DarkRPG.GUI.Tooltip.Desc.decreases..DarkRPG.GUI.Tooltip[id]..DarkRPG.GUI.Tooltip.Desc.by..stat[id]..DarkRPG.GUI.Tooltip.Desc.points -- '@decreases [Health] by [25] points'
	end
	iswpnstat = id == 'damage' or id == 'critical' or id == 'firerate' or id == 'magazine' or id == 'ammo'
	if stat[id] > 0 then
		return desc..DarkRPG.GUI.Tooltip.Desc.increases..DarkRPG.GUI.Tooltip[id]..(iswpnstat and (category or 'all weapons') or '')..DarkRPG.GUI.Tooltip.Desc.by..stat[id]..DarkRPG.GUI.Tooltip.Desc.percent -- '@increases [Evasion] by [25] %'
	end
	return desc..DarkRPG.GUI.Tooltip.Desc.decreases..DarkRPG.GUI.Tooltip[id]..(iswpnstat and (category or 'all weapons') or '')..DarkRPG.GUI.Tooltip.Desc.by..stat[id]..DarkRPG.GUI.Tooltip.Desc.percent -- '@decreases [Evasion] by [25] %'
end

function DarkRPG.updateTooltipText( title, desc, effect, runTwice )
	DarkRPG.tooltip.title:SetText( string.wrapwords(title,DarkRPG.GUI.Font.Tooltip_Title, DarkRPG.GUI.Tooltip_MaxWidth) )
	DarkRPG.tooltip.title:SizeToContents()
	DarkRPG.tooltip.title:SetPos(DarkRPG.GUI.Tooltip_Padding,16)

	DarkRPG.tooltip.desc:SetText( string.wrapwords(desc,DarkRPG.GUI.Font.Tooltip_Info, DarkRPG.GUI.Tooltip_MaxWidth) )
	DarkRPG.tooltip.desc:SizeToContents()
	DarkRPG.tooltip.desc:SetPos(DarkRPG.GUI.Tooltip_Padding+2,25 + DarkRPG.tooltip.title:GetTall())

	DarkRPG.tooltip.effect:SetText( string.wrapwords(effect,DarkRPG.GUI.Font.Tooltip_Info, DarkRPG.GUI.Tooltip_MaxWidth ) )-- multiline issues?
	DarkRPG.tooltip.effect:SizeToContents()
	DarkRPG.tooltip.effect:SetPos(DarkRPG.GUI.Tooltip_Padding+2,15+DarkRPG.tooltip.desc:GetTall() + DarkRPG.tooltip.desc.y)

	local w = DarkRPG.tooltip.effect.x + math.Clamp( math.max(DarkRPG.tooltip.title:GetWide(),DarkRPG.tooltip.desc:GetWide(),DarkRPG.tooltip.effect:GetWide()),0, DarkRPG.GUI.Tooltip_MaxWidth ) + DarkRPG.GUI.Tooltip_Padding
	local h = DarkRPG.tooltip.effect.y + DarkRPG.tooltip.effect:GetTall() + DarkRPG.GUI.Tooltip_Padding
	DarkRPG.tooltip:SetSize( w, h )

	if runTwice then return end
	timer.Simple(0.1, function()
		DarkRPG.updateTooltipText( DarkRPG.tooltip.title:GetText(), DarkRPG.tooltip.desc:GetText(), DarkRPG.tooltip.effect:GetText(), true ) 
	end)
end

function DarkRPG.createAddButton(label)
	add = vgui.Create( "DButton", DarkRPG.stat.box[label] )
	add:SetPos( DarkRPG.stat.box[label]:GetWide() - 24, DarkRPG.stat.box[label].label.y + 2 )
	add:SetSize(12,12)
	add:SetFont( DarkRPG.GUI.Font.StatBox_AddSub )
	add:SetText( "+" )
	add:SetTextColor( DarkRPG.GUI.Color.Stat_Txt or Color( 114, 114, 114 ) )
	add.DoClick = function()
		if input.IsKeyDown( KEY_LSHIFT ) or input.IsKeyDown( KEY_LSHIFT ) then
			DarkRPG.Config.SkillShiftClick = math.Clamp((DarkRPG.Config.SkillShiftClick or 10),0,(DarkRPG.Config.SkillShiftClick or 10))
			local addsp = math.Clamp(DarkRPG.getMaxSkillPoints() - DarkRPG.Player.spentSkills, 0, DarkRPG.getMaxSkillPoints())
			addsp = addsp < DarkRPG.Config.SkillShiftClick and addsp or DarkRPG.Config.SkillShiftClick
			if addsp > 0 then
				for i = 1, addsp do
					DarkRPG.convertSkillToStats( label )
				end
			end
		else
			DarkRPG.convertSkillToStats( label )
		end
		DarkRPG.updateBoxStat(label)
		DarkRPG.updateUsedPoints()
	end

	function add:Paint( w, h )
		if !add:IsHovered() then return end
		draw.RoundedBox( 0, 0, 0, w, h, DarkRPG.GUI.Color.Stat_Btn_Hover or Color( 53, 59, 64 ) )
	end
	DarkRPG.stat.box[label].add = add
end

function DarkRPG.createSubButton(label)
	local sub = vgui.Create( "DButton", DarkRPG.stat.box[label] )
	sub:SetPos(12, DarkRPG.stat.box[label].label.y + 2)
	sub:SetSize(12,12)
	sub:SetFont( DarkRPG.GUI.Font.StatBox_AddSub )
	sub:SetText( "-" )
	sub:SetTextColor( DarkRPG.GUI.Color.Stat_Txt or Color( 114, 114, 114 ) )
				
	sub.DoClick = function()
		if input.IsKeyDown( KEY_LSHIFT ) or input.IsKeyDown( KEY_LSHIFT ) then
			DarkRPG.Config.SkillShiftClick = math.Clamp((DarkRPG.Config.SkillShiftClick or 10),0,(DarkRPG.Config.SkillShiftClick or 10))
			local plyjob = DarkRPG.returnJobTableTeam()
			local subsp = (DarkRPG.Save[plyjob].SP[label] or 1) - DarkRPG.Config.SkillShiftClick
			subsp = subsp >= 0 and DarkRPG.Config.SkillShiftClick or math.Clamp(DarkRPG.Config.SkillShiftClick+subsp,0,DarkRPG.Config.SkillShiftClick)
			if subsp > 0 then
				for i = 1, subsp do
					DarkRPG.convertSkillToStats( label, true )
				end
			end
		else
			DarkRPG.convertSkillToStats( label, true )
		end
		DarkRPG.updateBoxStat(label)
		DarkRPG.updateUsedPoints()
	end

	function sub:Paint( w, h )
		if !sub:IsHovered() then return end
		draw.RoundedBox( 0, 0, 0, w, h, DarkRPG.GUI.Color.Stat_Btn_Hover or Color( 53, 59, 64 ) )
	end
	DarkRPG.stat.box[label].sub = sub
end

function DarkRPG.updateSubButton(label)
	if !DarkRPG.Config.SkillPointsOn then return end
	local noSkillPoints = DarkRPG.Player.spentSkills >= DarkRPG.getMaxSkillPoints()
	local bottomOut = (DarkRPG.Player.Stats[string.lower(label)].skill or 0) <= 0
	if !noSkillPoints and DarkRPG.Player.spentSkills <= DarkRPG.getMaxSkillPoints()-1 then
		for k, l in pairs( DarkRPG.GUI.Stat_Labels ) do
			DarkRPG.stat.box[l].add:SetVisible(true)
			DarkRPG.stat.box[l].add:SetDisabled(false)
		end
	end
	if bottomOut then
		DarkRPG.stat.box[label].sub:SetVisible(false)
		return
	end
	DarkRPG.stat.box[label].sub:SetVisible(true)
	DarkRPG.setResetButtonText(true)
end

function DarkRPG.updateAddButton(label)
	if !DarkRPG.Config.SkillPointsOn then return end
	local name = string.lower(label)
	local noSkillPoints = DarkRPG.Player.spentSkills >= DarkRPG.getMaxSkillPoints()
	local maxedOut = (DarkRPG.Player.Stats[name].skill or 0) >= DarkRPG.Skill.Max[name] --will probably break
	local bottomOut = (DarkRPG.Player.Stats[name].skill or 0) <= 0
	if noSkillPoints then 
		for k, l in pairs( DarkRPG.GUI.Stat_Labels ) do
			DarkRPG.stat.box[l].add:SetVisible(false)
			DarkRPG.stat.box[l].add:SetDisabled(true)
		end
		DarkRPG.setResetButtonText()
		return
	end
	if !bottomOut then
		DarkRPG.stat.box[label].sub:SetVisible(true)
		DarkRPG.stat.box[label].sub:SetDisabled(false)
	end
	if maxedOut then
		DarkRPG.stat.box[label].add:SetVisible(false)
		DarkRPG.stat.box[label].add:SetDisabled(true)
		return
	end
	DarkRPG.stat.box[label].add:SetVisible(true)
	DarkRPG.setResetButtonText(true)
end

function DarkRPG.updateAddSubButtons()
	if !DarkRPG.Config.SkillPointsOn then return end
	for k, label in pairs( DarkRPG.GUI.Stat_Labels ) do
		DarkRPG.updateAddButton(label)
		DarkRPG.updateSubButton(label)
	end
end

function DarkRPG.disableAddSubButtons()
	for k, l in pairs( DarkRPG.GUI.Stat_Labels ) do
		DarkRPG.stat.box[l].add:SetVisible(false)
		DarkRPG.stat.box[l].add:SetDisabled(true)
		DarkRPG.stat.box[l].sub:SetVisible(false)
		DarkRPG.stat.box[l].sub:SetDisabled(true)
	end
end

----------------------------------------------- TOOLTIP UPDATING AND TEXT PARSING -----------------------------------------------

function DarkRPG.updateTalentTree()
	local hud_tierSize = math.ceil(DarkRPG.Player.talentTreeSize/DarkRPG.Config.TalentWidth)

	function DarkRPG.tree:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 50, 50 ) ) -- remove this
	end

	if DarkRPG.tree.div != nil then DarkRPG.tree.div:Remove() end -- FIX
	DarkRPG.tree.div = vgui.Create( "DPanel", DarkRPG.tree )
	DarkRPG.tree.div:SetPos(DarkRPG.Config.TalentPadding*2,DarkRPG.Config.TalentPadding*2)
	DarkRPG.tree.div:SetSize(DarkRPG.frame:GetWide()-DarkRPG.Config.TalentPadding*DarkRPG.Config.TalentWidth, DarkRPG.Config.TalentButtonSize * hud_tierSize +(16*hud_tierSize) )

	if DarkRPG.tree.div:GetTall() < DarkRPG.tree:GetTall() then
		DarkRPG.tree.div:SetPos(DarkRPG.Config.TalentPadding+8,DarkRPG.Config.TalentPadding+8)
	end

	function DarkRPG.tree.div:Paint()
	end

	--------------------------------------------------------------------------------------------------------

	DarkRPG.tree.list = vgui.Create( "DIconLayout", DarkRPG.tree.div  )
	DarkRPG.tree.list:SetPos( 0, 0 )
	DarkRPG.tree.list:SetSpaceX( DarkRPG.Config.TalentPadding )
	DarkRPG.tree.list:SetSpaceY( DarkRPG.Config.TalentPadding )
	DarkRPG.tree.list:SetSize( DarkRPG.tree:GetWide(), DarkRPG.tree:GetTall() )
	DarkRPG.tree.list:SetName('statcontainer')

	--------------------------------------------------------------------------------------------------------

	DarkRPG.tree.talent = {}
	for i = 1, DarkRPG.Player.talentTreeSize do 
		local talent = DarkRPG.tree.list:Add( "DPanel" )
		talent:SetSize(DarkRPG.Config.TalentButtonSize, DarkRPG.Config.TalentButtonSize)
		talent:DockMargin(5,5,5,5)
		talent:SetName('talentbox'..i)

		function talent:Paint( w, h )
		end

		DarkRPG.tree.talent[i] = talent
	end

	for k, pt in pairs( DarkRPG.Player.Talents ) do
		pt.spent = 0
		local talent = DarkRPG.tree.talent[pt.pos]

		talent.button = vgui.Create( "DImageButton", talent )
		talent.button:SetPos(4, 4)
		talent.button:SetSize( talent:GetWide()-8, talent:GetTall()-8 )
		talent.button:SetText( "" )
		talent.button:SetImage( "materials/darkrpg2/"..pt.thumb or "error.png" )
		talent.button.DoClick = function()
			DarkRPG.updateTalentBox(pt)
		end

		function talent:Paint( w, h )
			draw.RoundedBox( 6, 0, 0, w, h, DarkRPG.GUI.Color.Talent_BG or Color( 42, 36, 36 ) )
			if self:IsChildHovered() or pt.spent > 0 then
				draw.RoundedBox( 6, 4, 4, w-8, h-8, DarkRPG.GUI.Color.Talent_FG_Used or Color( 164, 187, 187 ) )
			elseif pt.level > DarkRPG.Player.spentTalents then
				draw.RoundedBox( 6, 4, 4, w-8, h-8, DarkRPG.GUI.Color.Talent_FG or Color( 59, 67, 74 ) )
			else
				draw.RoundedBox( 6, 4, 4, w-8, h-8, DarkRPG.GUI.Color.Talent_FG_Active or Color( 62, 129, 180 ) )
			end
			DarkRPG.updateTooltip( talent, pt )
		end

		if pt.ranks != nil and pt.ranks > 1 then
			talent.ranks = vgui.Create( "DLabel", talent )
			talent.ranks:SetTextColor( DarkRPG.GUI.Color.Talent_Txt or Color( 245, 245, 245 ) )
			talent.ranks:SetFont( DarkRPG.GUI.Font.Talent_Ranks )
			talent.ranks:SetText( " 0/"..math.Clamp(pt.ranks,0,9) )
			talent.ranks:SizeToContents()
			talent.ranks:SetSize( talent.ranks:GetWide()+4, talent.ranks:GetTall()+4)
			talent.ranks:SetPos(0,talent:GetTall()-talent.ranks:GetTall()+2)

			function talent.ranks:Paint( w, h )
				draw.RoundedBox( 0, 0, 2, w, h, DarkRPG.GUI.Color.Talent_BG or Color( 42, 36, 36 ) )
			end
		end

		if pt.group != nil then
			talent.vip = vgui.Create( "DLabel", talent )
			talent.vip:SetTextColor( Color( 245, 245, 245 ) )
			talent.vip:SetFont( DarkRPG.GUI.Font.Talent_Ranks )
			talent.vip:SetText( " VIP " )
			talent.vip:SizeToContents()
			talent.vip:SetSize( talent.vip:GetWide(), talent.vip:GetTall())
			talent.vip:SetPos(talent:GetWide()-talent.vip:GetWide()-1,0)

			function talent.vip:Paint( w, h )
				draw.RoundedBox( 0, 0, 2, w, h, DarkRPG.GUI.Color.Talent_BG or Color( 42, 36, 36 ) )
			end
			DarkRPG.tree.talent[pt.pos] = talent
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

function DarkRPG.resizeInterface()
	if menu == nil or DarkRPG.frame == nil or DarkRPG.footer == nil then return end
	DarkRPG.header:SetPos( 2, 2 )
	DarkRPG.header:SetSize( DarkRPG.frame:GetWide()-4, DarkRPG.GUI.Title_Height-4)
	DarkRPG.switch:SetPos( DarkRPG.GUI.Title_Padding, (DarkRPG.GUI.Title_Height-DarkRPG.switch:GetTall())/2 )
	DarkRPG.close:SetPos( DarkRPG.frame:GetWide()-DarkRPG.close:GetWide()-DarkRPG.GUI.Title_Padding, (DarkRPG.GUI.Title_Height-DarkRPG.close:GetTall())/2 )
	DarkRPG.reset:SetPos( DarkRPG.frame:GetWide() - DarkRPG.reset:GetWide() - DarkRPG.GUI.Title_Padding, (DarkRPG.GUI.Title_Height-DarkRPG.reset:GetTall())/2-2 )
	DarkRPG.stat:SetPos( 2, DarkRPG.GUI.Title_Height-2 )
	DarkRPG.stat:SetSize( DarkRPG.frame:GetWide()-4, DarkRPG.frame:GetTall()-DarkRPG.GUI.Title_Height*2)
	DarkRPG.tree:SetPos( 2, DarkRPG.GUI.Title_Height-2 )
	DarkRPG.tree:SetSize( DarkRPG.frame:GetWide()-4, DarkRPG.frame:GetTall()-DarkRPG.GUI.Title_Height*2 + 2 )
	DarkRPG.help:SetPos( 2, DarkRPG.GUI.Title_Height-2 )
	DarkRPG.help:SetSize( DarkRPG.frame:GetWide()-4, DarkRPG.frame:GetTall()-DarkRPG.GUI.Title_Height*2 + 2 )
	DarkRPG.updateHelpMenu()
	
	for k, label in pairs( DarkRPG.GUI.Stat_Labels ) do 
		DarkRPG.stat.box[label]:SetSize( (DarkRPG.frame:GetWide() - 2 - 4) / 3, ( (DarkRPG.frame:GetTall()-DarkRPG.GUI.Title_Height*2) - 2 ) / 5)

		DarkRPG.stat.box[label].value:SizeToContents()
		DarkRPG.stat.box[label].value:Center()
		DarkRPG.stat.box[label].value:SetPos(DarkRPG.stat.box[label].value.x, DarkRPG.stat.box[label].value.y - 8)

		DarkRPG.stat.box[label].label:SizeToContents()
		DarkRPG.stat.box[label].label:Center()
		DarkRPG.stat.box[label].label:SetPos(DarkRPG.stat.box[label].label.x, DarkRPG.stat.box[label].label.y + 16)

		if DarkRPG.Config.SkillPointsOn then
			DarkRPG.stat.box[label].add:SetPos( DarkRPG.stat.box[label]:GetWide() - 24, DarkRPG.stat.box[label].label.y + 2 )
			DarkRPG.stat.box[label].sub:SetPos( 12, DarkRPG.stat.box[label].label.y + 2)
		end
	end

	local tierSize = math.Round(DarkRPG.Player.talentTreeSize/DarkRPG.Config.TalentWidth)
	local talwide = (DarkRPG.Config.TalentPadding+DarkRPG.Config.TalentButtonSize)*DarkRPG.Config.TalentWidth
	local taltall = (DarkRPG.Config.TalentPadding+DarkRPG.Config.TalentButtonSize)*tierSize

	DarkRPG.tree.div:SetSize( talwide, taltall )
	DarkRPG.tree.div:Center()

	-----------------------------------------------------------------------------------------

	local roundH = math.Round(((DarkRPG.frame:GetTall()-DarkRPG.GUI.Title_Height*2) - 2 ) / 5)*5+4

	DarkRPG.header:SetSize( DarkRPG.stat.box.Health:GetWide()*3+2, DarkRPG.header:GetTall() )
	DarkRPG.footer:SetSize( DarkRPG.stat.box.Health:GetWide()*3+2, DarkRPG.GUI.Title_Height-2)
	DarkRPG.footer:SetPos( 2, DarkRPG.stat.y + roundH )
	DarkRPG.stat:SetSize(DarkRPG.stat.box.Health:GetWide()*3+2, DarkRPG.stat:GetTall())
	DarkRPG.tree:SetSize(DarkRPG.stat.box.Health:GetWide()*3+2, DarkRPG.tree:GetTall())
	DarkRPG.help:SetSize(DarkRPG.stat.box.Health:GetWide()*3+2, DarkRPG.help:GetTall())
	DarkRPG.frame:SetSize( DarkRPG.frame:GetWide() , DarkRPG.stat.y + roundH + DarkRPG.GUI.Title_Height )

	local setminx = talwide+DarkRPG.Config.TalentPadding*2
	DarkRPG.frame:SetMinimumSize(setminx > 306 and setminx or 306, 306)

	-----------------------------------------------------------------------------------------

	local centery = DarkRPG.tree.div:GetTall() < DarkRPG.tree:GetTall() and math.Clamp( DarkRPG.tree:GetTall()/2-DarkRPG.tree.div:GetTall()/2, DarkRPG.tree.div.x + DarkRPG.Config.TalentPadding*0.5, ScrH()) or DarkRPG.tree.div.x + DarkRPG.Config.TalentPadding*0.5
	DarkRPG.tree.div:SetPos( DarkRPG.tree.div.x + DarkRPG.Config.TalentPadding*0.5, centery )

	DarkRPG.tree.list:SetSize( DarkRPG.tree.div:GetWide(), DarkRPG.tree.list:GetTall() )
	DarkRPG.tree.list:SetSpaceX( DarkRPG.Config.TalentPadding )
	DarkRPG.tree.list:SetSpaceY( DarkRPG.Config.TalentPadding )
end

function DarkRPG.resetInterface()
	
	DarkRPG.convertConfigToStats()
	DarkRPG.loadJobAndTalentFiles()
	DarkRPG.resetPlayerStats()

	---- DarkRPG.frame

	DarkRPG.frame = vgui.Create( "DFrame" )
	DarkRPG.frame:SetSize( DarkRPG.GUI.Width , DarkRPG.GUI.Height )
	DarkRPG.frame:SetMinimumSize( DarkRPG.Config.TalentWidth*DarkRPG.Config.TalentButtonSize > 306 and DarkRPG.Config.TalentWidth*DarkRPG.Config.TalentButtonSize or 306, 306 )
	DarkRPG.frame:SetTitle( "" )
	DarkRPG.frame:SetVisible( DarkRPG.Config.popupMenuOnJoin )
	DarkRPG.frame:SetDraggable( true )
	DarkRPG.frame:SetScreenLock( true )
	DarkRPG.frame:ShowCloseButton( false )
	DarkRPG.frame:SetPaintShadow( false )
	DarkRPG.frame:SetDeleteOnClose(false)
	DarkRPG.frame:SetSizable(true)
	DarkRPG.frame:MakePopup()
	DarkRPG.frame:Center()

	function DarkRPG.frame:Paint( w, h ) end

	---- DarkRPG.header
	
	DarkRPG.header = vgui.Create( "DPanel", DarkRPG.frame )
	DarkRPG.header:SetPos( 0, 0 )
	DarkRPG.header:SetSize( DarkRPG.frame:GetWide(), DarkRPG.GUI.Title_Height)

	function DarkRPG.header:Paint( w, h )
		draw.RoundedBoxEx( DarkRPG.GUI.Corner or 8, 0, 0, w, h, DarkRPG.GUI.Color.Title_BG or Color( 236, 114, 71 ), true, true, false, false )
	end

	---- DarkRPG.switch

	DarkRPG.switch = vgui.Create( "DButton", DarkRPG.header )
	DarkRPG.switch.hoverText = DarkRPG.GUI.Title_Talent_Text
	DarkRPG.switch.defaultText = DarkRPG.GUI.Title_Stat_Text
	DarkRPG.switch:SetFont( DarkRPG.GUI.Font.HeaderFooter )
	DarkRPG.switch:SetText( DarkRPG.switch.defaultText )
	DarkRPG.switch:SizeToContentsY()
	DarkRPG.switch:SetSize(string.checktextlen( DarkRPG.switch, DarkRPG.GUI.Title_Talent_Text, DarkRPG.GUI.Title_Stat_Text, DarkRPG.GUI.Title_Help_Text ), DarkRPG.switch:GetTall())
	DarkRPG.switch:SetPos( DarkRPG.GUI.Title_Padding, (DarkRPG.GUI.Title_Height-DarkRPG.switch:GetTall())/2 )
	DarkRPG.switch.DoClick = function()
		if !DarkRPG.stat:GetDisabled() then
			DarkRPG.stat:SetDisabled(true) --off
			DarkRPG.stat:SetVisible(false) --off
			if DarkRPG.Config.TalentPointsOn then
				DarkRPG.tree:SetDisabled(false) --on
				DarkRPG.tree:SetVisible(true) --on
				DarkRPG.help:SetDisabled(true) --off
				DarkRPG.help:SetVisible(false) --off
				DarkRPG.switch.hoverText = DarkRPG.GUI.Title_Help_Text
				DarkRPG.switch.defaultText = DarkRPG.GUI.Title_Talent_Text
				DarkRPG.switch:SetText( DarkRPG.GUI.Title_Talent_Text )
				DarkRPG.updateResetButtonSwitch()
				timer.Simple(0.1, function() DarkRPG.resizeInterface() end)
				return
			end
			DarkRPG.tree:SetDisabled(true) --off
			DarkRPG.tree:SetVisible(false) --off
			DarkRPG.help:SetDisabled(false) --on
			DarkRPG.help:SetVisible(true) --on
			DarkRPG.switch.hoverText = DarkRPG.GUI.Title_Stat_Text
			DarkRPG.switch.defaultText = DarkRPG.GUI.Title_Help_Text
			DarkRPG.switch:SetText( DarkRPG.GUI.Title_Help_Text )
			DarkRPG.updateResetButtonSwitch()
			return
		elseif !DarkRPG.tree:GetDisabled()  then
			DarkRPG.stat:SetDisabled(true) --off
			DarkRPG.stat:SetVisible(false) --off
			DarkRPG.tree:SetDisabled(true) --off
			DarkRPG.tree:SetVisible(false) --off
			DarkRPG.help:SetDisabled(false) --on
			DarkRPG.help:SetVisible(true) --on
			DarkRPG.switch.hoverText = DarkRPG.GUI.Title_Stat_Text
			DarkRPG.switch.defaultText = DarkRPG.GUI.Title_Help_Text
			DarkRPG.switch:SetText( DarkRPG.GUI.Title_Help_Text )
			DarkRPG.updateResetButtonSwitch()
			return
		end
		DarkRPG.stat:SetDisabled(false) --on
		DarkRPG.stat:SetVisible(true) --on
		DarkRPG.tree:SetDisabled(true) --off
		DarkRPG.tree:SetVisible(false) --off
		DarkRPG.help:SetDisabled(true) --off
		DarkRPG.help:SetVisible(false) --off
		if DarkRPG.Config.TalentPointsOn then
			DarkRPG.switch.hoverText = DarkRPG.GUI.Title_Talent_Text
		else DarkRPG.switch.hoverText = DarkRPG.GUI.Title_Help_Text end
		DarkRPG.switch.defaultText = DarkRPG.GUI.Title_Stat_Text
		DarkRPG.switch:SetText( DarkRPG.GUI.Title_Stat_Text )
		DarkRPG.updateResetButtonSwitch()
	end

	DarkRPG.switch.paintstop = false -- stops the menu from unecessarily changing text every frame pointlessly.
	function DarkRPG.switch:Paint( w, h )
		if DarkRPG.switch.paintstop and DarkRPG.switch:IsHovered() then
			DarkRPG.playSound(DarkRPG.Config.HeaderTitleSound)
			DarkRPG.switch:SetTextColor( DarkRPG.GUI.Color.Title_Txt_Hover or Color( 47, 70, 185 ) )
			DarkRPG.switch:SetText( DarkRPG.switch.hoverText )
			DarkRPG.switch.paintstop = false
		elseif !DarkRPG.switch.paintstop and !DarkRPG.switch:IsHovered() then
			DarkRPG.switch:SetTextColor( DarkRPG.GUI.Color.Title_Txt or Color( 252, 252, 252 ) )
			DarkRPG.switch:SetText( DarkRPG.switch.defaultText )
			DarkRPG.switch.paintstop = true
		end
	end

	function DarkRPG.switch.selectMenu(stat,tree,help)
		DarkRPG.playSound(DarkRPG.Config.OpenMenuSound)
		DarkRPG.frame:SetVisible(true)
		if DarkRPG.Config.TalentPointsOn then
			DarkRPG.tree:SetDisabled(!tree)
			DarkRPG.tree:SetVisible(tree)
		else
			DarkRPG.stat:SetDisabled(false)
			DarkRPG.stat:SetVisible(true)
			DarkRPG.stat:SetDisabled(true)
			DarkRPG.stat:SetVisible(false)
			DarkRPG.help:SetDisabled(true)
			DarkRPG.help:SetVisible(false)
			DarkRPG.switch.DoClick()
			return
		end
		DarkRPG.stat:SetDisabled(!stat)
		DarkRPG.stat:SetVisible(stat)
		DarkRPG.help:SetDisabled(!help)
		DarkRPG.help:SetVisible(help)
		DarkRPG.switch.DoClick()
	end
	DarkRPG.swepSwitchMenu = DarkRPG.switch.selectMenu

	---- DarkRPG.close

	DarkRPG.close = vgui.Create( "DImageButton", DarkRPG.header )
	DarkRPG.close:SetText( "" )
	DarkRPG.close:SetSize( 20, 20 )
	DarkRPG.close:SetImage( "materials/darkrpg2/x.png" )
	DarkRPG.close:SetPos( DarkRPG.frame:GetWide()-DarkRPG.close:GetWide()-DarkRPG.GUI.Title_Padding, (DarkRPG.GUI.Title_Height-DarkRPG.close:GetTall())/2 )
	DarkRPG.close.DoClick = function()
		DarkRPG.playSound(DarkRPG.Config.CloseMenuSound)
		DarkRPG.frame:Close()
		DarkRPG.tooltip:Close()
	end
	DarkRPG.close.paintstop = false -- stops the menu from unecessarily changing text every frame pointlessly.
	function DarkRPG.close:Paint( w, h )
		if DarkRPG.close:IsHovered() then
			draw.RoundedBox( 8, 0, 0, w, h, DarkRPG.GUI.Color.Frame_BG or Color( 34, 37, 42 ) )
		end
		if DarkRPG.close.paintstop and  DarkRPG.close:IsHovered() then
			DarkRPG.playSound(DarkRPG.Config.HeaderTitleSound)
			DarkRPG.close.paintstop = false
		elseif !DarkRPG.close.paintstop and !DarkRPG.close:IsHovered() then
			DarkRPG.close.paintstop = true
		end
	end

	---- DarkRPG.footer

	DarkRPG.footer = vgui.Create( "DPanel", DarkRPG.frame )
	DarkRPG.footer:SetPos( 0, DarkRPG.frame:GetTall() - DarkRPG.GUI.Title_Height + 2 )
	DarkRPG.footer:SetSize( DarkRPG.frame:GetWide(), DarkRPG.GUI.Title_Height)

	function DarkRPG.footer:Paint( w, h )
		draw.RoundedBoxEx( DarkRPG.GUI.Corner or 8, 0, 0, w, h, DarkRPG.GUI.Color.Title_BG or Color( 236, 114, 71 ), false, false, true, true )
	end

	---- DarkRPG.points

	DarkRPG.points = vgui.Create( "DLabel", DarkRPG.footer )
	DarkRPG.points:SetFont( DarkRPG.GUI.Font.HeaderFooter )
	DarkRPG.points:SetText( "Points: NIL" )
	DarkRPG.points:SizeToContents()
	DarkRPG.points:SetPos( DarkRPG.GUI.Title_Padding, (DarkRPG.GUI.Title_Height-DarkRPG.points:GetTall())/2-2 )

	---- DarkRPG.reset

	DarkRPG.reset = vgui.Create( "DButton", DarkRPG.footer )
	DarkRPG.reset:SetFont( DarkRPG.GUI.Font.HeaderFooter )
	DarkRPG.reset.DoClick = function()
		DarkRPG.updateResetButton()
	end

	DarkRPG.reset.paintstop = false -- stops the menu from unecessarily changing text every frame pointlessly.
	function DarkRPG.reset:Paint( w, h )
		if DarkRPG.reset.paintstop and  DarkRPG.reset:IsHovered() then
			DarkRPG.playSound(DarkRPG.Config.HeaderTitleSound)
			DarkRPG.reset:SetTextColor( DarkRPG.GUI.Color.Title_Txt_Hover or Color( 47, 70, 185 ) )
			DarkRPG.reset.paintstop = false
		elseif !DarkRPG.reset.paintstop and !DarkRPG.reset:IsHovered() then
			DarkRPG.reset:SetTextColor( DarkRPG.GUI.Color.Title_Txt or Color( 252, 252, 252 ) )
			DarkRPG.reset.paintstop = true
		end
	end

	--stat.container
	DarkRPG.stat = vgui.Create( "DIconLayout", DarkRPG.frame )
	DarkRPG.stat:SetPos( 0, DarkRPG.GUI.Title_Height )
	DarkRPG.stat:SetSize( DarkRPG.frame:GetWide(), DarkRPG.frame:GetTall()-DarkRPG.GUI.Title_Height*2)
	DarkRPG.stat:SetSpaceX( 1 )
	DarkRPG.stat:SetSpaceY( 1 )

	function DarkRPG.stat:Paint( w, h )
		draw.RoundedBoxEx( 0, 0, 0, w, h, DarkRPG.GUI.Color.Frame_BG or Color( 34, 37, 42 ), false, false, true, true )
	end

	DarkRPG.stat.box = {} -- create blank box value
	local drawbox = {}
	local label = DarkRPG.GUI.Stat_Labels
	local cnr = {
		{false, false, false, true},
		{false, false, true, true},
		{false, false, true, false},
		{false, true, false, true},
		{true, true, true, true},
		{true, false, true, false},
		{false, true, false, true},
		{true, true, true, true},
		{true, false, true, false},
		{false, true, false, true},
		{true, true, true, true},
		{true, false, true, false},
		{false, true, false, false},
		{true, true, false, false},
		{true, false, false, false},
	}
	for k, lbl in pairs( label ) do 
		local box = DarkRPG.stat:Add( "DPanel" )
		box:SetSize( (DarkRPG.frame:GetWide() - 2) / 3, ( (DarkRPG.frame:GetTall()-DarkRPG.GUI.Title_Height*2) - 2 ) / 5)
		box:SetName(lbl)

		drawbox[lbl] = function( w, h )
			if !box:IsHovered() then draw.RoundedBoxEx( DarkRPG.GUI.Corner or 8, 0, 0, w, h, DarkRPG.GUI.Color.Stat_Btn or Color( 43, 49, 54 ), cnr[k][1], cnr[k][2], cnr[k][3], cnr[k][4] ) return end
			draw.RoundedBoxEx( DarkRPG.GUI.Corner or 8, 0, 0, w, h, DarkRPG.GUI.Color.Stat_Btn_Hover or Color( 53, 59, 64 ), cnr[k][1], cnr[k][2], cnr[k][3], cnr[k][4] )
		end

		function box:Paint( w, h )
			DarkRPG.updateTooltip( box, nil )
			drawbox[lbl]( w, h )
		end

		-- Stat.box.value
		box.value = vgui.Create( "DLabel", box )
		box.value:SetFont( DarkRPG.GUI.Font.StatBox_Value )

		-- Stat.box.label
		box.label = vgui.Create( "DLabel", box )
		box.label:SetFont( DarkRPG.GUI.Font.StatBox_Label )
		box.label:SetText( DarkRPG.GUI.Tooltip.Desc[lbl] or lbl )
		box.label:SetTextColor( DarkRPG.GUI.Color.Stat_Txt or Color( 114, 114, 114 ) )
		box.label:SizeToContents()
		box.label:Center()
		box.label:SetPos(box.label.x, box.label.y + 16)

		DarkRPG.stat.box[lbl] = box

		if DarkRPG.Config.SkillPointsOn then 
			DarkRPG.createAddButton(lbl)
			DarkRPG.createSubButton(lbl)
		end
	end

	---- DarkRPG.tooltip

	DarkRPG.tooltip = vgui.Create( "DFrame" )
	DarkRPG.tooltip:SetSize( 250, 150 )
	DarkRPG.tooltip:SetTitle( "" )
	DarkRPG.tooltip:ShowCloseButton( false )
	DarkRPG.tooltip:SetPaintShadow( true )
	DarkRPG.tooltip:SetMouseInputEnabled(false)
	DarkRPG.tooltip:SetDeleteOnClose(false)
	DarkRPG.tooltip:MakePopup()
	DarkRPG.tooltip:SetVisible( false )

	DarkRPG.tooltip.title = vgui.Create( "DLabel", DarkRPG.tooltip )
	DarkRPG.tooltip.title:SetTextColor( DarkRPG.GUI.Color.Tooltip_Title or Color( 252, 252, 252 ) )
	DarkRPG.tooltip.title:SetFont( DarkRPG.GUI.Font.Tooltip_Title )

	DarkRPG.tooltip.desc = vgui.Create( "DLabel", DarkRPG.tooltip )
	DarkRPG.tooltip.desc:SetTextColor( DarkRPG.GUI.Color.Tooltip_Desc or Color( 112, 112, 112 ) )
	DarkRPG.tooltip.desc:SetFont( DarkRPG.GUI.Font.Tooltip_Info )

	DarkRPG.tooltip.effect = vgui.Create( "DLabel", DarkRPG.tooltip )
	DarkRPG.tooltip.effect:SetTextColor( DarkRPG.GUI.Color.Tooltip_Effect or Color( 46, 166, 48 ) )
	DarkRPG.tooltip.effect:SetFont( DarkRPG.GUI.Font.Tooltip_Info )

	function DarkRPG.tooltip:Think()
		self:MoveToFront()
	end

	---- DarkRPG.tree

	DarkRPG.tree = vgui.Create( "DScrollPanel", DarkRPG.frame )

	DarkRPG.tree:SetPos( 0, DarkRPG.GUI.Title_Height )
	DarkRPG.tree:SetSize( DarkRPG.frame:GetWide(), DarkRPG.frame:GetTall()-DarkRPG.GUI.Title_Height*2 + 2 )

	function DarkRPG.tree:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, DarkRPG.GUI.Color.Talent_Frame_BG or Color( 43, 49, 54 ) )
	end

	local mtsbar = DarkRPG.tree:GetVBar()
	function mtsbar:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, DarkRPG.GUI.Color.Scroll_BG or Color( 22, 26, 28 ) )
	end
	function mtsbar.btnUp:Paint( w, h )
		draw.RoundedBox( 0, 2, 2, w-4, h-4, DarkRPG.GUI.Color.Scroll_Grip or Color( 43, 49, 54 ) )
	end
	function mtsbar.btnDown:Paint( w, h )
		draw.RoundedBox( 0, 2, 2, w-4, h-4, DarkRPG.GUI.Color.Scroll_Grip or Color( 43, 49, 54 ) )
	end
	function mtsbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 2, 2, w-4, h-4, DarkRPG.GUI.Color.Scroll_Grip or Color( 43, 49, 54 ) )
	end

	---- DarkRPG.cover
	
	DarkRPG.help = vgui.Create( "DScrollPanel", DarkRPG.frame )

	DarkRPG.help:SetPos( 0, DarkRPG.GUI.Title_Height )
	DarkRPG.help:SetSize( DarkRPG.frame:GetWide(), DarkRPG.frame:GetTall()-DarkRPG.GUI.Title_Height*2 + 2 )

	function DarkRPG.help:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, DarkRPG.GUI.Color.Help_BG or Color( 43, 49, 54 ))
	end

	local mhsbar = DarkRPG.help:GetVBar()
	function mhsbar:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, DarkRPG.GUI.Color.Scroll_BG or Color( 22, 26, 28 ) )
	end
	function mhsbar.btnUp:Paint( w, h )
		draw.RoundedBox( 0, 2, 2, w-4, h-4, DarkRPG.GUI.Color.Scroll_Grip or Color( 43, 49, 54 ) )
	end
	function mhsbar.btnDown:Paint( w, h )
		draw.RoundedBox( 0, 2, 2, w-4, h-4, DarkRPG.GUI.Color.Scroll_Grip or Color( 43, 49, 54 ) )
	end
	function mhsbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 2, 2, w-4, h-4, DarkRPG.GUI.Color.Scroll_Grip or Color( 43, 49, 54 ) )
	end

	DarkRPG.help.info = vgui.Create( "DLabel", DarkRPG.help )
	DarkRPG.help.info:SetTextColor( DarkRPG.GUI.Color.Help_Txt or Color( 205, 205, 205 ) )
	DarkRPG.help.info:SetFont( DarkRPG.GUI.Font.Tooltip_Info )

	DarkRPG.help.info:SetPos( 20, 20 )
	DarkRPG.help.info:SetSize( DarkRPG.frame:GetWide() - DarkRPG.GUI.Tooltip_Padding*2, 100 )
	DarkRPG.updateHelpMenu()

	--DarkRPG.help
	
	DarkRPG.updateTooltipText("Untitled Talent", "NIL Information and Stuff", "Current Effects:\nNIL")
	DarkRPG.updateTalentTree()
	DarkRPG.updateAddSubButtons() -- NEVER PUT TALENT OR SKILL + or - INFORMATION IN THIS FUNCTION
	if !DarkRPG.Config.SkillPointsOn then 
		DarkRPG.reset:SetVisible(false) 
		DarkRPG.points:SetVisible(false) 
	end

	DarkRPG.setResetButtonText(true)

	DarkRPG.tree:SetDisabled(true)
	DarkRPG.tree:SetVisible(false)
	DarkRPG.help:SetDisabled(true)
	DarkRPG.help:SetVisible(false)

	DarkRPG.resizeInterface()

	DarkRPG.resetInterface = function() end
end

--------------------------------------------------------------------------------------------------------

function DarkRPG.loadJobAndTalentFiles()
	for k, f in pairs( DarkRPG.Config.IncludeJobFiles ) do
		print("DarkRPG CLIENT: Including talent and stat files --> '"..f..".lua'!")
		AddCSLuaFile( "darkrp_modules/darkrpg2/jobs/"..f..".lua" )
		include( "darkrp_modules/darkrpg2/jobs/"..f..".lua" )
	end
	print("DarkRPG CLIENT: Finished loading talent and stat files!")
end

function DarkRPG.sendPlayerTotalsToServer()
	local totals = {}
	for k, n in pairs( DarkRPG.GUI.Stat_VarNames ) do
		totals[n] = DarkRPG.Player.Stats[n].total
	end
	
	totals.key = DarkRPG.key or -1

	totals.health = (totals.health or 0) * 100 + 100
	totals.movement = (totals.movement or 0) * (DarkRP.GAMEMODE.Config.runspeed or 240) + DarkRP.GAMEMODE.Config.runspeed or 240
	totals.jump = (totals.jump or 0) * 200 + 200

	totals.armor = (totals.armor or 0) * 100 or 0
	totals.evasion = (totals.evasion or 0) * 100
	totals.reflect = (totals.reflect or 0) * 100

	totals.salary = totals.salary + 1 -- fixed because darkrp updated and it broke calling jobtable somehow :/
	totals.merchant = totals.merchant or 0
	totals.prison = (totals.prison or 0) * DarkRP.GAMEMODE.Config.jailtimer or 120

	totals.damage = 1 + (totals.damage or 0)
	totals.firerate = 1 - (totals.firerate or 0)
	totals.critical = (totals.critical or 0) * 100
	totals.magazine = 1 + (totals.magazine or 0)
	totals.ammo = 1 + (totals.ammo or 0)

	totals.resists = 1 - (totals.resists or 0)
	totals.burn = 1 - (totals.burn or 0)
	totals.crush = 1 - (totals.crush or 0)
	totals.explode = 1 - (totals.explode or 0)
	totals.endurance = 1 - (totals.endurance or 0)

	totals.give = DarkRPG.Player.Give
	totals.weapon = {}

	for w, wpn in pairs ( DarkRPG.Player.Weapon ) do
		totals.weapon[w] = {}
		totals.weapon[w].damage = (wpn.damage != nil and (totals.damage + wpn.damage or 0)) or nil
		totals.weapon[w].firerate = (wpn.firerate != nil and (totals.firerate - wpn.firerate or 0)) or nil
		totals.weapon[w].critical = (wpn.critical != nil and (totals.critical + ((wpn.critical or 0) * 100))) or nil
		totals.weapon[w].magazine = (wpn.magazine != nil and (totals.magazine + (wpn.magazine or 0))) or nil
		totals.weapon[w].ammo = (wpn.ammo != nil and (totals.ammo + (wpn.ammo or 0))) or nil
	end

	net.Start( "drpgps" )
	net.WriteTable( totals )
	net.SendToServer()
end

function DarkRPG.savePlayerSettings()
	if DarkRPG.Player.spentSkills < 0 or DarkRPG.Player.spentSkills > DarkRPG.getMaxSkillPoints() then return end
	local table = util.TableToJSON( DarkRPG.Save )
	file.Write( "drpg_"..(DarkRPG.SaveId or '')..".dat", table )
end

function DarkRPG.loadPlayerSettings()
	local f = "drpg_"..(DarkRPG.SaveId or '')..".dat"
	if (file.Exists(f, "DATA")) then
		DarkRPG.resetSkillPoints()
		DarkRPG.resetTalentPoints()
		DarkRPG.resetPlayerStats()
		DarkRPG.updateTalentTree()

		file.Open(f,"r","DATA")
		local info = util.JSONToTable( file.Read(f,"DATA") )
		
		if type(info) != 'table' then return end

		DarkRPG.Save = {}
		DarkRPG.Save = info

		DarkRPG.applyPlayerSettings()
		DarkRPG.updateUsedPoints()
		DarkRPG.sendPlayerTotalsToServer()
		DarkRPG.setResetButtonText(true)
		return
	end
	DarkRPG.sendPlayerTotalsToServer()
end

function DarkRPG.applyPlayerSettings()
	local plyjob = DarkRPG.returnJobTableTeam()
	if DarkRPG.Save[plyjob] == nil then return end

	local dupStop

	if DarkRPG.Config.SkillPointsOn then
		local spcheck = 0
		local maxsp = DarkRPG.getMaxSkillPoints()

		if DarkRPG.Save[plyjob].SP != nil then
		for k, l in pairs( DarkRPG.GUI.Stat_Labels ) do
			if DarkRPG.Save[plyjob].SP[l] != nil then
				dupStop = DarkRPG.Save[plyjob].SP[l] --Added to avoid duplication of values issue
				DarkRPG.Save[plyjob].SP[l] = 0 --Added to avoid duplication of values issue
				for i=1, dupStop do
					if !(spcheck >= maxsp) then
						DarkRPG.convertSkillToStats( l )
						spcheck = spcheck + 1
					end
				end
			end
		end
		end
	end

	if DarkRPG.Config.TalentPointsOn then
		local tpcheck = 0
		local maxtp = DarkRPG.getMaxTalentPoints()
		
		if DarkRPG.Save[plyjob].TP != nil then
		for p, pt in pairs( DarkRPG.Player.Talents ) do
			if DarkRPG.Save[plyjob].TP[p] != nil then
				dupStop = DarkRPG.Save[plyjob].TP[p] --Added to avoid duplication of values issue
				DarkRPG.Save[plyjob].TP[p] = 0 --Added to avoid duplication of values issue
				for i=1, dupStop do
					if !(tpcheck >= maxtp) then
						DarkRPG.updateTalentBox(pt)
						tpcheck = tpcheck + 1
					end
				end
			end
		end
		end
	end
end

function DarkRPG.playSound(sound)
	if !DarkRPG.Config.PlaySounds or !istable(sound) then return end
	LocalPlayer():EmitSound(sound[1], 100, sound[2], 0.01*sound[3])
end

-- Receives the sent value from the server
net.Receive("drpgpl", function(len)
    local lvl = net.ReadInt( 10 )
    DarkRPG.SaveId = net.ReadInt( 30 )
	DarkRPG.key = net.ReadInt( 30 )
    DarkRPG.updateClientStats( lvl )
end )

function DarkRPG.updateClientStats(level)
    DarkRPG.Player.level = DarkRPG.Config.NoLevelingMode and DarkRPG.Config.MaximumTalentPoints or level -- function doesn't work
    if DarkRPG.frame == nil then
    	DarkRPG.Player.spentTalents = 0 -- for each value in DarkRPG.Player.Talents[i], add a property called ".spent" to track talent values.
    	DarkRPG.Player.spentSkills = 0
    	DarkRPG.resetInterface()
		DarkRPG.loadPlayerSettings()

		hook.Add("OnPlayerChangedTeam", "DarkRPG_ChangeJob", function(ply) 
			DarkRPG.tooltip.stopDisplay = true
			timer.Simple( 1, function()
			DarkRPG.savePlayerSettings()
			DarkRPG.loadPlayerSettings()
			DarkRPG.resizeInterface()
			timer.Simple(1, function() DarkRPG.tooltip.stopDisplay = false end)
			end)
		end )
    end
end

DarkRPG.hudIsMoving = false
DarkRPG.hudIsVisible = DarkRPG.Config.popupMenuOnJoin
DarkRPG.keyIsDown = false

hook.Add( "VGUIMousePressed", "DarkRPG_MousePressed", function()
	if DarkRPG.frame == nil then return end
	if DarkRPG.header:IsHovered() then
		DarkRPG.hudIsMoving = true
		offx = DarkRPG.frame.x - gui.MouseX()
		offy = DarkRPG.frame.y - gui.MouseY()
	end
	DarkRPG.header.OnMouseReleased = function()
		DarkRPG.hudIsMoving = false
	end
end)

hook.Add( "GUIMouseReleased", "DarkRPG_MouseReleased", function()
	DarkRPG.hudIsMoving = false
end)

hook.Add( "Think", "DarkRPG_ToggleHUD", function()
	if DarkRPG.frame == nil then return end
	local key = DarkRPG.GUI.ToggleKey and input.IsKeyDown( DarkRPG.GUI.ToggleKey ) or nil
	if key and !DarkRPG.keyIsDown then 
		DarkRPG.keyIsDown = true
	elseif DarkRPG.keyIsDown and !key then
		DarkRPG.keyIsDown = false
		DarkRPG.hudIsVisible = true
		DarkRPG.frame:SetVisible( DarkRPG.hudIsVisible )
		DarkRPG.playSound(DarkRPG.Config.OpenMenuSound)
	elseif DarkRPG.hudIsMoving then
		local x = math.Clamp( gui.MouseX() + offx , 0 , surface.ScreenWidth() - DarkRPG.frame:GetWide() )
		local y = math.Clamp( gui.MouseY() + offy , 0 , surface.ScreenHeight() - DarkRPG.frame:GetTall() )
		DarkRPG.frame:SetPos( x, y )
	end
	if DarkRPG.frame.oldTall != DarkRPG.frame:GetTall() or DarkRPG.frame.oldWide != DarkRPG.frame:GetWide()  then
		DarkRPG.resizeInterface()
		DarkRPG.frame.frameAfter = true
	elseif DarkRPG.frame.frameAfter then
		timer.Simple(0.3, function() DarkRPG.resizeInterface() end)
		DarkRPG.frame.frameAfter = false
	end
	DarkRPG.frame.oldTall = DarkRPG.frame:GetTall()
	DarkRPG.frame.oldWide = DarkRPG.frame:GetWide()
end )

-- Receives the sent value from the server
net.Receive("darkrpg_HitNumber", function(len)
    local pos = net.ReadVector()
    local dmg = net.ReadInt( 14 )
    local msg = net.ReadInt( 3 )
    local hit = {
    	pos = pos,
    	text = msg == 1 and 'Critical! '..dmg or msg == 2 and 'Evade!' or msg == 3 and 'Reflected! '..dmg or dmg,
    	decay = 200,
	}
	table.insert(DarkRPG.HitNumbers, hit)
end )

hook.Add( "PostDrawTranslucentRenderables", "DarkRPG_ShotHUD", function()
	if DarkRPG.Config.HitNumbers and #DarkRPG.HitNumbers > 0 then
		cam.IgnoreZ(true);

		for i, hit in pairs( DarkRPG.HitNumbers ) do
			local Pos = hit.pos
			local Ang = Angle( 0, LocalPlayer():EyeAngles()[2], 0 )

			surface.SetFont("EOTI_HIT_100")
			local TextWidth = surface.GetTextSize(hit.text)

			Ang:RotateAroundAxis(Ang:Forward(), 90)
			local TextAng = Ang
			TextAng:RotateAroundAxis(TextAng:Right(), 90)
			cam.Start3D2D(Pos + Ang:Right() * -(250-hit.decay), TextAng, 0.2)
				draw.SimpleTextOutlined( hit.text, "EOTI_HIT_100", -TextWidth*0.5 + 5, -100, Color(255,255,255, hit.decay) , 0, 0, 3, Color(0,0,0,hit.decay) )
			cam.End3D2D()
			
			hit.decay = hit.decay - 1
			if hit.decay <= 0 then table.remove( DarkRPG.HitNumbers, i ) end
		end

		cam.IgnoreZ(false);
	end
end)