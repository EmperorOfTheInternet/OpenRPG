-- Bodybuilder is in general.lua
DarkRPG.createTalent({
	name = "Cadet Training",
	team = {TEAM_POLICE, TEAM_CHIEF},
	pos = {3,1},
	thumb = "cadet.png",
	ranks = 4,
	stats = {
		evasion = "2%",
		damage = "2%",
		firerate = "1%",
	},
})
DarkRPG.createTalent({
	name = "Service Revolver",
	team = {TEAM_POLICE, TEAM_CHIEF},
	pos = {4,1},
	thumb = "revolver.png",
	group = {"donator","admin"},
	give = "weapon_357",
	desc = "Buying VIP issues you a .357 Magnum Handcannon!",
})

--------------------------------------------------------------
DarkRPG.createTalent({
	name = "Career Service",
	team = {TEAM_POLICE, TEAM_CHIEF},
	pos = {1,2},
	thumb = "career.png",
	ranks = 3,
	stats = {
		salary = "10%",
	},
})
DarkRPG.createTalent({
	name = "Athletic",
	team = {TEAM_POLICE, TEAM_CHIEF},
	pos = {2,2},
	thumb = "athletic.png",
	ranks = 3,
	stats = {
		movement = "10%",
		jump = "10%",
		endurance = "10%"
	},
})
-- Tactical Accessories is in general.lua
DarkRPG.createTalent({
	name = "Kevlar Vest",
	team = {TEAM_POLICE, TEAM_CHIEF},
	pos = {4,2},
	thumb = "kevlar.png",
	ranks = 3,
	stats = {
		armor = "10",
		movement = "-3%",
		firerate = "-2%",
	},
})
--------------------------------------------------------------
DarkRPG.createTalent({
	name = "Quantity Over Quality",
	team = {TEAM_POLICE, TEAM_CHIEF},
	pos = {1,3},
	thumb = "quantity.png",
	ranks = 3,
	stats = {
		damage = "-8%",
	},
	weaponcategory = {
		name = "Rifles",
		stats = {
			firerate = "10%",
		},
	},
})
DarkRPG.createTalent({
	name = "Defensive Tactics",
	team = {TEAM_POLICE, TEAM_CHIEF},
	pos = {2,3},
	thumb = "defensive.png",
	ranks = 4,
	stats = {
		movement = "2%",
	},
	weaponcategory = {
		name = "Melee and Non-Lethals",
		stats = {
			damage = "5%",
			firerate = "5%",
		},
	},
})
DarkRPG.createTalent({
	name = "War Bag",
	team = {TEAM_POLICE, TEAM_CHIEF},
	pos = {3,3},
	thumb = "warbag.png",
	ranks = 2,
	stats = {
		ammo = "25%",
	},
})
DarkRPG.createTalent({
	name = "Handcannon Harry",
	team = {TEAM_POLICE, TEAM_CHIEF},
	pos = {4,3},
	thumb = "harry.png",
	ranks = 3,
	stats = {
		firerate = "-10%",
	},
	weaponcategory = {
		name = "Handguns",
		stats = {
			damage = "10%",
		},
	},
})
--------------------------------------------------------------
DarkRPG.createTalent({
	name = "Officer Discount",
	team = {TEAM_POLICE, TEAM_CHIEF},
	pos = {1,4},
	thumb = "discount.png",
	ranks = 2,
	stats = {
		merchant = "15%",
	},
})
DarkRPG.createTalent({
	name = "Less Than Lethal",
	team = {TEAM_POLICE, TEAM_CHIEF},
	pos = {2,4},
	thumb = "martial.png",
	ranks = 3,
	stats = {
		evasion = "2%",
		health = "6%",
	},
	weaponcategory = {
		name = "Melee and Non-Lethals",
		stats = {
			damage = "10%",
		},
	},
})
DarkRPG.createTalent({
	name = "Dirty Cop",
	team = {TEAM_POLICE, TEAM_CHIEF},
	pos = {4,4},
	thumb = "dirtycop.png",
	ranks = 2,
	stats = {
		salary = "10%",
		merchant = "5%",
		prison = "-25%",
	},
})
--------------------------------------------------------------
DarkRPG.createTalent({
	name = "Distinguished Service",
	team = {TEAM_POLICE, TEAM_CHIEF},
	pos = {1,5},
	thumb = "distinguished.png",
	ranks = 3,
	stats = {
		salary = "10%",
	},
})
DarkRPG.createTalent({
	name = "SWAT Training",
	team = {TEAM_POLICE, TEAM_CHIEF},
	pos = {2,5},
	thumb = "swat.png",
	ranks = 5,
	stats = {
		armor = "4",
	},
	weaponcategory = {
		name = 'Submachine guns',
		stats = {
			damage = "4%",
			magazine = "10%"
		},
	},
})
-- War Veteran in general.lua
-- Sniper Training in general.lua
--------------------------------------------------------------
DarkRPG.createTalent({
	name = "Captain",
	team = {TEAM_POLICE, TEAM_CHIEF},
	pos = {1,6},
	thumb = "captain.png",
	stats = {
		salary = "100%",
		merchant = "75%",
		damage = "20%",
	},
})

DarkRPG.createTalent({
	name = "Juggernaut Suit",
	team = TEAM_POLICE,
	pos = {2,6},
	thumb = "juggernaut.png",
	stats = {
		armor = "50",
		explode = "75%",
		resists = "10%",
		reflect = "5%",
		movement = "-90%",
		jump = "-90%"
	},
	desc = 'The Juggernaut Suit hugely increases damage resistances, but you can no longer sprint or jump.'
})






