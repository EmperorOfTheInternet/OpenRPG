-- detailed explanation can be found here
-- https://docs.google.com/document/d/1dqLyZUZ7HouEbp7okLxJaGqeHVtdl__f6j2S0pt2aPg/edit#heading=h.99dczrexpgrd

-- any values you don't need in createJobSkills or createTalent you should comment out or delete,
-- leaving them as 'health = '0'' or 'health = nil' makes your file longer and could use up extra ram needlessly

-- also, don't, forgot, the, dashes, after, each, variable, or, table.
-- You will, because I forgot them all the time!
-- Also check the console to see if you made typos or illegal values!
-- DarkRPG prints out invalid talent values and tells you how to fix them in the console!

-- adds these values to the player at Level 1 automatically.
DarkRPG.createJobSkills({
	team = {TEAM_EXAMPLE1, TEAM_EXAMPLE2},
	--team = TEAM_EXAMPLE

	-- player stats
	stats = {
		health = '1',
		movement = '1%',
		jump = '1%',

		armor = '1',
		evasion = '1%',
		reflect = '1%',

		salary = '1%',
		merchant = '1%',
		prison = '1%',

		-- damage resists
		resists = '1%', -- all incoming sources of damage 
		burn = '1%', -- burn, ignite, shock, dissolve
		endurance = '1%', -- poison, nerve, drowning, radiation, acid
		crush = '1%', -- crush, vehicle crush, falling damage, physgun
		explode = '1%', -- explosives, plasma, sonicboom

		-- applies to all weapons
		damage = '1%',
		critical = '1%',
		firerate = '1%',
		magazine = '1%',
		ammo = '1%',
	},

	-- applies to a specific set of weapons
	weaponcategory = {
		name = "Handguns", -- must match name you set in 'weapons.lua' EXACTLY
		stats = {
			damage = '1%',
			critical = '1%',
			firerate = '1%',
			magazine = '1%',
			ammo = '1%',
		},
	},
})

-- adds a talent button
DarkRPG.createTalent({
	name = "My_Example_Talent",
	team = {TEAM_EXAMPLE1, TEAM_EXAMPLE2},
	pos = {1,1}, -- x and y on the talent tree
	thumb = "myexample.png", -- must be in '/materials/darkrpg2/myexample.png'
	ranks = 9, -- ranks 1 through 9
	desc = "This is my example talent, delete the 'desc' line if you want the tooltip text generated automatically! ",

	-- player stats
	stats = {
		health = '1',
		movement = '1%',
		jump = '1%',

		armor = '1',
		evasion = '1%',
		reflect = '1%',

		salary = '1%',
		merchant = '1%',
		prison = '1%',

		-- damage resists
		resists = '1%', -- all incoming sources of damage 
		burn = '1%', -- burn, ignite, shock, dissolve
		endurance = '1%', -- poison, nerve, drowning, radiation, acid
		crush = '1%', -- crush, vehicle crush, falling damage, physgun
		explode = '1%', -- explosives, plasma, sonicboom

		-- applies to all weapons
		damage = '1%',
		critical = '1%',
		firerate = '1%',
		magazine = '1%',
		ammo = '1%',
	},

	-- applies to a specific set of weapons
	weaponcategory = {
		name = "MK9 Shotguns", -- must match name you set in 'weapons.lua' EXACTLY
		stats = {
			damage = '1%',
			critical = '1%',
			firerate = '1%',
			magazine = '1%',
			ammo = '1%',
		},
	},
})