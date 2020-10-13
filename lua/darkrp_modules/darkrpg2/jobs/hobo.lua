DarkRPG.createTalent({
	name = "Slippery Hobo",
	team = {TEAM_HOBO},
	pos = {1,1},
	thumb = "slipperyhobo.png",
	ranks = 5,
	stats = {
		evasion = "4%",
	},
})
DarkRPG.createTalent({
	name = "Raging Crackhead",
	team = {TEAM_HOBO},
	pos = {2,1},
	thumb = "ragingcrackhead.png",
	stats = {
		health = "25",
		resists = "-15%",
	},
})
DarkRPG.createTalent({
	name = "Hobobar",
	team = {TEAM_HOBO},
	pos = {3,1},
	thumb = "hoboknife.png",
	give = "weapon_crowbar",
	desc = "Knockin' out folks with muh hobobar! (Gives crowbar on spawn)",
})
DarkRPG.createTalent({
	name = "Poopslinger",
	team = {TEAM_HOBO},
	pos = {4,1},
	thumb = "poopslinger.png",
	ranks = 5,
	weaponcategory = {
		name = "Poopslinging",
		stats = {
			firerate = "2%",
		},
	},
})
------------------------------
DarkRPG.createTalent({
	name = "Wandering Willie",
	team = {TEAM_HOBO},
	pos = {1,2},
	thumb = "wanderingwillie.png",
	ranks = 5,
	stats = {
		movement = "4%",
		evasion = "1%",
	},
})
DarkRPG.createTalent({
	name = "Public Intoxication",
	team = {TEAM_HOBO},
	pos = {4,2},
	thumb = "publicintoxication.png",
	ranks = 5,
	stats = {
		health = "10%",
		firerate = "-2%"
	},
})
------------------------------
DarkRPG.createTalent({
	name = "Trash Parkour",
	team = {TEAM_HOBO},
	pos = {1,3},
	thumb = "trashparkour.png",
	ranks = 5,
	stats = {
		jump = "15%",
		crush = "-10%",
	},
})
DarkRPG.createTalent({
	name = "Burn Victim",
	team = {TEAM_HOBO},
	pos = {4,3},
	thumb = "burnvictim.png",
	ranks = 5,
	stats = {
		burn = "15%",
	},
	desc = "Burn Victim improves the hobo's ability to live inside trash can fires by 15% per rank.",
})
------------------------------
DarkRPG.createTalent({
	name = "Poverty Singularity",
	team = {TEAM_HOBO},
	pos = {1,4},
	thumb = "povertysingularity.png",
	ranks = 5,
	stats = {
		merchant = "-10%",
	},
})
DarkRPG.createTalent({
	name = "Hobo Ninjitsu",
	team = {TEAM_HOBO},
	pos = {4,4},
	thumb = "hoboninja.png",
	ranks = 5,
	stats = {
		reflect = "5%",
	},
	weaponcategory = {
		name = "Melee and Non-Lethals",
		stats = {
			damage = "2.5%",
			critical = "2%",
		},
	},
})
------------------------------
DarkRPG.createTalent({
	name = "Hobo Luck",
	team = {TEAM_HOBO},
	pos = {1,5},
	thumb = "hoboluck.png",
	ranks = 5,
	stats = {
		evasion = "2%",
		reflect = "2%",
		critical = "2%",
	},
})
DarkRPG.createTalent({
	name = "Shitlord",
	team = {TEAM_HOBO},
	pos = {4,5},
	thumb = "shitlord.png",
	ranks = 5,
	weaponcategory = {
		name = "Poopslinging",
		stats = {
			firerate = "5%",
		},
	},
})
------------------------------
DarkRPG.createTalent({
	name = "Hobo Ghost",
	team = {TEAM_HOBO},
	pos = {1,6},
	thumb = "hoboghost.png",
	stats = {
		evasion = "50%",
		reflect = "50%",
		health = "-90%",
		damage = "-90%",
	},
})
DarkRPG.createTalent({
	name = "Hobo King",
	team = {TEAM_HOBO},
	pos = {4,6},
	thumb = "hoboking.png",
	stats = {
		health = "100%",
		damage = "25%",
		prison = "-100%",
	},
})