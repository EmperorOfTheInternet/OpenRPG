if DarkRPG.Config.Language then
	print("DarkRPG CLIENT: Including 'language/"..DarkRPG.Config.Language..".lua'!")
	include( "darkrp_modules/darkrpg2/language/"..DarkRPG.Config.Language..".lua" )
end

DarkRPG.GUI.Tooltip.Desc.Health = DarkRPG.GUI.Tooltip.Desc.Health or "Health"
DarkRPG.GUI.Tooltip.Desc.Movement = DarkRPG.GUI.Tooltip.Desc.Movement or "Movement"
DarkRPG.GUI.Tooltip.Desc.Jump = DarkRPG.GUI.Tooltip.Desc.Jump or "Jump"

DarkRPG.GUI.Tooltip.Desc.Armor = DarkRPG.GUI.Tooltip.Desc.Armor or "Armor"
DarkRPG.GUI.Tooltip.Desc.Evasion = DarkRPG.GUI.Tooltip.Desc.Evasion or "Evasion"
DarkRPG.GUI.Tooltip.Desc.Reflect = DarkRPG.GUI.Tooltip.Desc.Reflect or "Reflect"

DarkRPG.GUI.Tooltip.Desc.Salary = DarkRPG.GUI.Tooltip.Desc.Salary or "Salary"
DarkRPG.GUI.Tooltip.Desc.Merchant = DarkRPG.GUI.Tooltip.Desc.Merchant or "Merchant"
DarkRPG.GUI.Tooltip.Desc.Prison = DarkRPG.GUI.Tooltip.Desc.Prison or "Prison"

DarkRPG.GUI.Tooltip.Desc.Damage = DarkRPG.GUI.Tooltip.Desc.Damage or "Damage"
DarkRPG.GUI.Tooltip.Desc.Resists = DarkRPG.GUI.Tooltip.Desc.Resists or "Resists"
DarkRPG.GUI.Tooltip.Desc.Critical = DarkRPG.GUI.Tooltip.Desc.Critical or "Critical"
DarkRPG.GUI.Tooltip.Desc.Firerate = DarkRPG.GUI.Tooltip.Desc.Firerate or "Firerate"
DarkRPG.GUI.Tooltip.Desc.Magazine = DarkRPG.GUI.Tooltip.Desc.Magazine or "Magazine"
DarkRPG.GUI.Tooltip.Desc.Ammo = DarkRPG.GUI.Tooltip.Desc.Ammo or "Ammo"

DarkRPG.GUI.Tooltip.Desc.requiresPrefix = DarkRPG.GUI.Tooltip.Desc.requiresPrefix or 'Requires '
DarkRPG.GUI.Tooltip.Desc.talentUnlocked = DarkRPG.GUI.Tooltip.Desc.talentUnlocked or 'This talent is unlocked!'
DarkRPG.GUI.Tooltip.Desc.pointsToUnlock = DarkRPG.GUI.Tooltip.Desc.pointsToUnlock or ' spent talent points to unlock'
DarkRPG.GUI.Tooltip.Desc.mustBeInVIP = DarkRPG.GUI.Tooltip.Desc.mustBeInVIP or 'Requires you to be in user group '
DarkRPG.GUI.Tooltip.Desc.linkcomma = DarkRPG.GUI.Tooltip.Desc.linkcomma or ', '
DarkRPG.GUI.Tooltip.Desc.linkor = DarkRPG.GUI.Tooltip.Desc.linkor or 'or '
DarkRPG.GUI.Tooltip.Desc.linkcommaand = DarkRPG.GUI.Tooltip.Desc.linkcommaand or ', and '
DarkRPG.GUI.Tooltip.Desc.linkand = DarkRPG.GUI.Tooltip.Desc.linkand or 'and '
DarkRPG.GUI.Tooltip.Desc.period = DarkRPG.GUI.Tooltip.Desc.period or '.'
DarkRPG.GUI.Tooltip.Desc.serverSide = DarkRPG.GUI.Tooltip.Desc.serverSide or 'Serverside max value is +'
DarkRPG.GUI.Tooltip.Desc.percent = DarkRPG.GUI.Tooltip.Desc.percent or '%'
DarkRPG.GUI.Tooltip.Desc.points = DarkRPG.GUI.Tooltip.Desc.points or ' points'
DarkRPG.GUI.Tooltip.Desc.by = DarkRPG.GUI.Tooltip.Desc.by or ' by '

-- 'gives you a 'm9k_handcannon' on player spawn'
DarkRPG.GUI.Tooltip.Desc.givesYou = DarkRPG.GUI.Tooltip.Desc.givesYou or 'gives you a '
DarkRPG.GUI.Tooltip.Desc.onPlayerSpawn = DarkRPG.GUI.Tooltip.Desc.onPlayerSpawn or ' on player spawn'

DarkRPG.GUI.Tooltip.Desc.perRank = DarkRPG.GUI.Tooltip.Desc.perRank or ' per rank'

DarkRPG.GUI.Tooltip.Desc.increases = DarkRPG.GUI.Tooltip.Desc.increases or 'increases '
DarkRPG.GUI.Tooltip.Desc.decreases = DarkRPG.GUI.Tooltip.Desc.decreases or 'decreases '

DarkRPG.GUI.Tooltip.Desc.plussign = DarkRPG.GUI.Tooltip.Desc.plussign or '+'
DarkRPG.GUI.Tooltip.Desc.colon = DarkRPG.GUI.Tooltip.Desc.colon or ': '
DarkRPG.GUI.Tooltip.Desc.talents = DarkRPG.GUI.Tooltip.Desc.talents or 'Talents: '
DarkRPG.GUI.Tooltip.Desc.skills = DarkRPG.GUI.Tooltip.Desc.skills or 'Skills: '
DarkRPG.GUI.Tooltip.Desc.playerJob = DarkRPG.GUI.Tooltip.Desc.playerJob or 'Player Job: '

DarkRPG.GUI.Tooltip.Desc.resistInfo = DarkRPG.GUI.Tooltip.Desc.resistInfo or ' % ( Job / Talent / Skill ) -- [ Max Value ]'
DarkRPG.GUI.Tooltip.Desc.resistAllDamage = DarkRPG.GUI.Tooltip.Desc.resistAllDamage or 'All Damage'
DarkRPG.GUI.Tooltip.Desc.resistFireDamage = DarkRPG.GUI.Tooltip.Desc.resistFireDamage or 'Fire Resist'
DarkRPG.GUI.Tooltip.Desc.resistPoisonDrown = DarkRPG.GUI.Tooltip.Desc.resistPoisonDrown or 'Poison/Drown Resist'
DarkRPG.GUI.Tooltip.Desc.resistCrushFall = DarkRPG.GUI.Tooltip.Desc.resistCrushFall or 'Crush/Falling'
DarkRPG.GUI.Tooltip.Desc.resistExplosives = DarkRPG.GUI.Tooltip.Desc.resistExplosives or 'Explosives'
DarkRPG.GUI.Tooltip.Desc.modifiers = DarkRPG.GUI.Tooltip.Desc.modifiers or 'Modifiers:'

DarkRPG.GUI.Tooltip.Desc.talentNameError = DarkRPG.GUI.Tooltip.Desc.talentNameError or 'Untitled Talent'

DarkRPG.GUI.Tooltip.Desc.health = DarkRPG.GUI.Tooltip.Desc.health or 'Sets your maximum hit points on player spawn.'
DarkRPG.GUI.Tooltip.Desc.movement = DarkRPG.GUI.Tooltip.Desc.movement or 'Increases how fast you can sprint, will not affect default walking speed.'
DarkRPG.GUI.Tooltip.Desc.jump = DarkRPG.GUI.Tooltip.Desc.jump or 'Increases your maximum jumping height, will not reduce falling damage.'

DarkRPG.GUI.Tooltip.Desc.armor = DarkRPG.GUI.Tooltip.Desc.armor or 'Sets your armor points on player spawn.'
DarkRPG.GUI.Tooltip.Desc.evasion = DarkRPG.GUI.Tooltip.Desc.evasion or 'Increases your chance to dodge an incoming attack from ALL damage sources.'
DarkRPG.GUI.Tooltip.Desc.reflect = DarkRPG.GUI.Tooltip.Desc.reflect or 'Increases your chance to both dodge and then reflect an incoming attack back at your attacker.'

DarkRPG.GUI.Tooltip.Desc.salary = DarkRPG.GUI.Tooltip.Desc.salary or 'Increases the how much money you receive each payday, determined by your job salary.'
DarkRPG.GUI.Tooltip.Desc.merchant = DarkRPG.GUI.Tooltip.Desc.merchant or 'Reduces the cost of buying shipments for this job.'
DarkRPG.GUI.Tooltip.Desc.prison = DarkRPG.GUI.Tooltip.Desc.prison or 'Reduces time spent in prison when arrested.'

DarkRPG.GUI.Tooltip.Desc.damage = DarkRPG.GUI.Tooltip.Desc.damage or "Increases damage with all weapons and tools, determined by your weapon's default speed."
DarkRPG.GUI.Tooltip.Desc.resists = DarkRPG.GUI.Tooltip.Desc.resists or "Increases resistances to specific types of damage. ‘All Damage’ does not stack with the other resist types."
DarkRPG.GUI.Tooltip.Desc.critical = DarkRPG.GUI.Tooltip.Desc.critical or 'Increases chance for a critical strike with your weapon for 150% total damage.'

DarkRPG.GUI.Tooltip.Desc.firerate = DarkRPG.GUI.Tooltip.Desc.firerate or "Increases firing rate with all weapons and tools, determined by your weapon's default speed."
DarkRPG.GUI.Tooltip.Desc.magazine = DarkRPG.GUI.Tooltip.Desc.magazine or "Increases magazine size with all weapons and tools, determined by your weapon's default magazine size."
DarkRPG.GUI.Tooltip.Desc.ammo = DarkRPG.GUI.Tooltip.Desc.ammo or "Increases ammo on respawn, job change and weapon pick up, determined by your weapon's clip size and default ammo."

DarkRPG.GUI.Tooltip.health = DarkRPG.GUI.Tooltip.health or 'maximum health'
DarkRPG.GUI.Tooltip.movement = DarkRPG.GUI.Tooltip.movement or 'player movement'
DarkRPG.GUI.Tooltip.jump = DarkRPG.GUI.Tooltip.jump or 'jump height'

DarkRPG.GUI.Tooltip.armor = DarkRPG.GUI.Tooltip.armor or 'armor on spawn'
DarkRPG.GUI.Tooltip.evasion = DarkRPG.GUI.Tooltip.evasion or 'chance to evade incoming attacks'
DarkRPG.GUI.Tooltip.reflect = DarkRPG.GUI.Tooltip.reflect or 'chance to reflect incoming damage back at the attacker'

DarkRPG.GUI.Tooltip.salary = DarkRPG.GUI.Tooltip.salary or 'job salary'
DarkRPG.GUI.Tooltip.merchant = DarkRPG.GUI.Tooltip.merchant or 'savings on purchased items and taxes'
DarkRPG.GUI.Tooltip.prison = DarkRPG.GUI.Tooltip.prison or 'prison time reduction'

DarkRPG.GUI.Tooltip.damage = DarkRPG.GUI.Tooltip.damage or 'damage with '
DarkRPG.GUI.Tooltip.magazine = DarkRPG.GUI.Tooltip.magazine or 'magazine size with '
DarkRPG.GUI.Tooltip.ammo = DarkRPG.GUI.Tooltip.ammo or 'additional ammo on spawn or from pickups with '
DarkRPG.GUI.Tooltip.critical = DarkRPG.GUI.Tooltip.critical or 'critical chance with '
DarkRPG.GUI.Tooltip.firerate = DarkRPG.GUI.Tooltip.firerate or 'firerate and accuracy with '

DarkRPG.GUI.Tooltip.resists = DarkRPG.GUI.Tooltip.resists or 'resistance to all damage'
DarkRPG.GUI.Tooltip.burn = DarkRPG.GUI.Tooltip.burn or 'resistance to burning'
DarkRPG.GUI.Tooltip.crush = DarkRPG.GUI.Tooltip.crush or 'resistance to fall damage and prop crush'
DarkRPG.GUI.Tooltip.endurance = DarkRPG.GUI.Tooltip.endurance or 'resistance to drowning and poison'
DarkRPG.GUI.Tooltip.explode = DarkRPG.GUI.Tooltip.explode or 'resistance to explosives'

DarkRPG.GUI.Title_Talent_Text = DarkRPG.GUI.Title_Talent_Text or 'Talent Tree'
DarkRPG.GUI.Title_Stat_Text = DarkRPG.GUI.Title_Stat_Text or 'Player Skills'
DarkRPG.GUI.Title_Help_Text = DarkRPG.GUI.Title_Help_Text or 'Server Info'
DarkRPG.GUI.Title_Padding = DarkRPG.GUI.Title_Padding or 14
DarkRPG.GUI.Title_Height = DarkRPG.GUI.Title_Height or 38
DarkRPG.GUI.Footer_Confirm_Text = DarkRPG.GUI.Footer_Confirm_Text or 'Confirm'
DarkRPG.GUI.Footer_Reset_Text = DarkRPG.GUI.Footer_Reset_Text or 'Reset Points'
DarkRPG.GUI.Talent_Padding = DarkRPG.GUI.Talent_Padding or 12
DarkRPG.GUI.Tooltip_MaxWidth = DarkRPG.GUI.Tooltip_MaxWidth or 300
DarkRPG.GUI.Tooltip_Padding = DarkRPG.GUI.Tooltip_Padding or 20