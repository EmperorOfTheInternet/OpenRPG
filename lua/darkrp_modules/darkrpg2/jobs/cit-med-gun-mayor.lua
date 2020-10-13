DarkRPG.createTalent({
	name = "First Aid Certification",
	team = {TEAM_MEDIC},
	pos = {4,1},
	thumb = "firstaidcert.png",
	ranks = 5,
	weaponcategory = {
		name = "Medical Equipment",
		stats = {
			firerate = "2%",
		},
	},
})
DarkRPG.createTalent({
	name = "Hippocratic Pacifism",
	team = {TEAM_MEDIC},
	pos = {4,2},
	thumb = "hippocraticpacifism.png",
	stats = {
		damage = "-100%",
		health = "30",
		evasion = "10%",
	},
	desc = "Your weapons no longer deal any damage, but health is increased by 30 points and your evasion by 10%.",
})
DarkRPG.createTalent({
	name = "Emergency Technician",
	team = {TEAM_MEDIC},
	pos = {4,3},
	thumb = "emergencytechnician.png",
	ranks = 3,
	stats = {
		movement = "5%",
		evasion = "2%",
		endurance = "10%",
	},
})
DarkRPG.createTalent({
	name = "Glock N' Heal",
	team = {TEAM_MEDIC},
	pos = {4,4},
	thumb = "glocknheal.png",
	stats = {
		damage = "-10%",
		firerate = "5%",
	},
	desc = "If you have the Hippocratic Pacifist talent, your weapons will now heal for 10 health per shot and all weapons fire 5% faster and more accurately.",
})
DarkRPG.createTalent({
	name = "Triage",
	team = {TEAM_MEDIC},
	pos = {4,5},
	thumb = "triage.png",
	ranks = 3,
	stats = {
		movement = "5%",
		health = "5",
		resists = "5%"
	},
	weaponcategory = {
		name = "Medical Equipment",
		stats = {
			firerate = "3%",
		},
	},
})
DarkRPG.createTalent({
	name = "Ghandi with a Gat",
	team = {TEAM_MEDIC},
	pos = {4,6},
	thumb = "ghandiwithagat.png",
	stats = {
		damage = "-25%",
	},
	weaponcategory = {
		name = "Medical Equipment",
		stats = {
			firerate = "5%",
		},
	},
	desc = "If you have the Hippocratic Pacifist talent, your weapons will now heal for an additional 25 health per shot and all weapons fire 20% faster and more accurately.",
})
DarkRPG.createTalent({
	name = "Combat Medic",
	team = {TEAM_MEDIC},
	pos = {3,6},
	thumb = "combatmedic.png",
	stats = {
		health = "50",
		armor = "35",
		damage = "15%",
	},
})
----------------------------------------
DarkRPG.createTalent({
	name = "Gun Runner",
	team = {TEAM_GUN},
	pos = {4,1},
	thumb = "gunrunner.png",
	ranks = 2,
	stats = {
		merchant = "2.5%",
		damage = "5%",
		prison = "-15%",
	},
})
DarkRPG.createTalent({
	name = "Insider Trading",
	team = {TEAM_GUN},
	pos = {4,2},
	thumb = "insidertrading.png",
	ranks = 5,
	stats = {
		salary = "5%",
		prison = "-5%",
	},
})
DarkRPG.createTalent({
	name = "Black Market Connections",
	team = {TEAM_GUN, TEAM_GANG, TEAM_MOB},
	pos = {4,3},
	thumb = "blackmarketconnections.png",
	ranks = 2,
	stats = {
		merchant = "5%",
		ammo = "10%",
		prison = "-25%",
	},
})
DarkRPG.createTalent({
	name = "Capitalist",
	team = {TEAM_GUN},
	pos = {4,4},
	thumb = "capitalist.png",
	ranks = 3,
	stats = {
		merchant = "5%",
		salary = "3%",
	},
})
DarkRPG.createTalent({
	name = "Store Commando",
	team = {TEAM_GUN},
	pos = {4,5},
	thumb = "storecommando.png",
	ranks = 3,
	stats = {
		damage = "2%",
		speed = "1%",
		ammo = "5%",
	},
})
----------------------------------------
DarkRPG.createTalent({
	name = "Lord of War",
	team = {TEAM_GUN},
	pos = {4,6},
	thumb = "lordofwar.png",
	stats = {
		damage = "2%",
		speed = "1%",
		ammo = "5%",
	},
})
----------------------------------------
DarkRPG.createTalent({
	name = "Embezzlement",
	team = {TEAM_MAYOR},
	pos = {4,1},
	thumb = "embezzlement.png",
	ranks = 5,
	stats = {
		salary = "6%",
	},
})
DarkRPG.createTalent({
	name = "Police Protection",
	team = {TEAM_MAYOR},
	pos = {4,2},
	thumb = "policeprotection.png",
	ranks = 3,
	stats = {
		armor = "10",
	},
})
DarkRPG.createTalent({
	name = "Endemic Corruption",
	team = {TEAM_MAYOR},
	pos = {4,3},
	thumb = "endemiccorruption.png",
	ranks = 4,
	stats = {
		merchant = "5%",
		prison = "5%",
	},
})
DarkRPG.createTalent({
	name = "Cowardice",
	team = {TEAM_MAYOR},
	pos = {4,4},
	thumb = "cowardice.png",
	ranks = 3,
	stats = {
		movement = "5%",
		evasion = "3%",
	},
})
DarkRPG.createTalent({
	name = "Kickbacks",
	team = {TEAM_MAYOR},
	pos = {4,5},
	thumb = "dirtycop.png",
	ranks = 2,
	stats = {
		salary = "6%",
		merchant = "5%",
		ammo = "10%",
	},
})
DarkRPG.createTalent({
	name = "Untouchable",
	team = {TEAM_MAYOR},
	pos = {4,6},
	thumb = "untouchable.png",
	stats = {
		prison = "100%",
	},
})
DarkRPG.createTalent({
	name = "Oligarchy",
	team = {TEAM_MAYOR},
	pos = {1,6},
	thumb = "oligarchy.png",
	stats = {
		salary = "100%",
	},
})