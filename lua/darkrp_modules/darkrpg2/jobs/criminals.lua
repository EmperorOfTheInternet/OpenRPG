-- Bodybuilder is in general.lua
DarkRPG.createTalent({
	name = "Prison Snitch",
	team = {TEAM_GANG, TEAM_MOB},
	pos = {1,1},
	thumb = "prisonsnitch.png",
	ranks = 2,
	stats = {
		prison = "20%",
	},
})
DarkRPG.createTalent({
	name = "Cat Burglar",
	team = {TEAM_GANG, TEAM_MOB},
	pos = {4,1},
	thumb = "catburglar.png",
	ranks = 5,
	stats = {
		salary = "4%",
		jumping = "4%",
		prison = "-2%",
	},
	weaponcategory = {
		name = "Lockpicks",
		stats = {
			firerate = "3%",
		},
	},
})
----------------------------------
DarkRPG.createTalent({
	name = "Home Invader",
	team = {TEAM_GANG, TEAM_MOB},
	pos = {1,2},
	thumb = "homeinvader.png",
	ranks = 2,
	stats = {
		health = "5",
		armor = "5",
	},
})
-- Footballer is in general.lua
-- Tactical Accessories is in general.lua
DarkRPG.createTalent({
	name = "Money Laundering",
	team = {TEAM_GANG, TEAM_MOB},
	pos = {4,2},
	thumb = "moneylaundering.png",
	ranks = 3,
	stats = {
		salary = "10%",
		prison = "-5%",
	},
})
----------------------------------
DarkRPG.createTalent({
	name = "Electronics Fraud",
	team = {TEAM_GANG, TEAM_MOB},
	pos = {1,3},
	thumb = "electronicsfraud.png",
	ranks = 2,
	stats = {
		salary = "10%",
		prison = "-5%"
	},
})
DarkRPG.createTalent({
	name = "Parkour",
	team = {TEAM_GANG, TEAM_MOB},
	pos = {2,3},
	thumb = "parkour.png",
	ranks = 3,
	stats = {
		jump = "10%",
		crush = "12%",
	},
	give = "climb_swep2",
	desc = "Parkour increases jump height by 10% and reduces crush damage by 12% per rank and you receive Jon a scone's Climb SWEP 2 (if it is installed).",
})
DarkRPG.createTalent({
	name = "Gone in 59 Seconds",
	team = {TEAM_GANG, TEAM_MOB},
	pos = {3,3},
	thumb = "gonein59s.png",
	ranks = 3,
	stats = {
		movement = "3%",
		crush = "3%",
	},
	weaponcategory = {
		name = "Lockpicks",
		stats = {
			firerate = "2%",
		},
	},
})
-- Black Market Connections is in cit-med-gun-mayor.lua
----------------------------------
DarkRPG.createTalent({
	name = "Heroin Addict",
	team = {TEAM_GANG, TEAM_MOB},
	pos = {1,4},
	thumb = "heroinaddict.png",
	stats = {
		health = "-30",
		damage = "20%",
		movement = "-10%",
	},
})
-- Martial Artist is in general.lua
-- Marksman is in general.lua
DarkRPG.createTalent({
	name = "Serial Killer",
	team = {TEAM_GANG, TEAM_MOB},
	pos = {4,4},
	thumb = "serialkiller.png",
	ranks = 5,
	stats = {
		prison = "-12%",
		evasion = "2%"
	},
	weaponcategory = {
		name = "Melee and Non-Lethals",
		stats = {
			critical = "5%",
			firerate = "3%",
		},
	},
})
----------------------------------
DarkRPG.createTalent({
	name = "Escape Artist",
	team = {TEAM_GANG, TEAM_MOB},
	pos = {1,5},
	thumb = "escapeartist.png",
	ranks = 4,
	stats = {
		jump = "10%",
		prison = "10%",
	},
})
DarkRPG.createTalent({
	name = "Domestic Terrorism",
	team = {TEAM_GANG, TEAM_MOB},
	pos = {2,5},
	thumb = "domesticterrorism.png",
	ranks = 4,
	stats = {
		prison = "-20%",
	},
	weaponcategory = {
		name = "Explosives",
		stats = {
			damage = "25%",
		},
	},
})
-- War Veteran in general.lua
-- Sniper Training in general.lua
----------------------------------
DarkRPG.createTalent({
	name = "Criminal Mastermind",
	team = {TEAM_GANG, TEAM_MOB},
	pos = {1,6},
	thumb = "criminalmastermind.png",
	stats = {
		merchant = "50%",
		salary = "50%",
		prison = "-100%",
	},
})
DarkRPG.createTalent({
	name = "Assassin",
	team = {TEAM_GANG, TEAM_MOB},
	pos = {2,6},
	thumb = "assassin.png",
	stats = {
		critical = "15%",
		damage = "20%",
		firerate = "25%",
	},
})
----------------------------------