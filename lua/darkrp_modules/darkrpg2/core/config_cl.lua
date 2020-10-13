DarkRPG = {}
DarkRPG.Config = {}

DarkRPG.GUI = {} 
DarkRPG.GUI.Color = {}
DarkRPG.GUI.Font = {}
DarkRPG.GUI.Tooltip = {}
DarkRPG.GUI.Tooltip.Desc = {}

DarkRPG.Skill = {}
DarkRPG.Skill.Max = {}
DarkRPG.Skill.Min = {}
DarkRPG.Talent = {}
DarkRPG.Job = {}

DarkRPG.Player = {}
DarkRPG.Player.Donator = {}
DarkRPG.Player.Job = {}
DarkRPG.Player.Stats = {}
DarkRPG.Player.Talents = {}
DarkRPG.Player.Give = {}
DarkRPG.Player.Weapon = {}

DarkRPG.HitNumbers = {}

DarkRPG.Save = {}

DarkRPG.WeaponCategories = {}

-- Changing any of these GUI.Stat_ values will break everything including player save files.
DarkRPG.GUI.Stat_Labels = { "Health", "Movement", "Jump", "Armor", "Evasion", "Reflect", "Salary", "Merchant", "Prison", "Damage", "Resists", "Critical", "Firerate", "Magazine", "Ammo" }
DarkRPG.GUI.Stat_VarNames = { "health", "movement", "jump", "armor", "evasion", "reflect", "salary", "merchant", "prison", "damage", "magazine", "ammo", "critical", "firerate", "resists", "burn", "crush", "endurance", "explode" }
DarkRPG.GUI.Stat_ResistNames = { "resists", "burn", "crush", "endurance", "explode" }
DarkRPG.GUI.Stat_WeaponNames = { "damage", "firerate", "magazine", "ammo", "critical" }

for k, i in pairs( DarkRPG.GUI.Stat_VarNames ) do
	DarkRPG.Player.Stats[i] = {}
end

-- These values are set if you delete a value from config.lua so it doesn't explode the interface you silly person.

DarkRPG.GUI.Height = 468
DarkRPG.GUI.Width = 353
DarkRPG.GUI.ToggleKey = false
DarkRPG.Config.HUDStyle = "PlainHUD"
DarkRPG.Config.HitNumbers = false
DarkRPG.Config.DisplayErrors = true
DarkRPG.Config.DelayToReset = 20

DarkRPG.Config.NoLevelingMode = false
DarkRPG.Config.Language = 'english'
DarkRPG.Config.popupMenuOnJoin = false

DarkRPG.Config.OpenMenuSound = { Sound('items/ammocrate_open.wav'), 100, 100 }
DarkRPG.Config.CloseMenuSound = { Sound('items/ammocrate_close.wav'), 100, 100 }
DarkRPG.Config.StatTalentHoverSound = { Sound('npc/metropolice/vo/on1.wav'), 100, 100 }
DarkRPG.Config.HeaderTitleSound = { Sound('npc/metropolice/vo/on2.wav'), 100, 100 }
DarkRPG.Config.PlayerLevelUpSound = { Sound('items/suitchargeok1.wav'), 100, 100 }

DarkRPG.Config.TalentPointsOn = true
DarkRPG.Config.MaximumTalentPoints = 26
DarkRPG.Config.NextTierMinimum = 5
DarkRPG.Config.TalentPointsPerLevel = 1.
DarkRPG.Config.TalentWidth = 1
DarkRPG.Config.TalentButtonSize = 64
DarkRPG.Config.TalentPadding = 6

DarkRPG.Config.SkillPointsOn = true -- if false, the stat menu appears, but you can't add skill points anymore.
DarkRPG.Config.MaximumSkillPoints = 150 -- The maximum skill points you can have, default is you get 150 points even if you're level 1000.
DarkRPG.Config.SkillPointsPerLevel = 3 -- The number of skill points you gain per level.
DarkRPG.Config.SkillShiftClick = 10

DarkRPG.Skill.health = "1"
DarkRPG.Skill.movement = "0.5%"
DarkRPG.Skill.jump = "1%"

DarkRPG.Skill.armor = "0.5"
DarkRPG.Skill.evasion = "0.5%"
DarkRPG.Skill.reflect = "0.25%"

DarkRPG.Skill.salary = "1%"
DarkRPG.Skill.merchant = "0.2%"
DarkRPG.Skill.prison = "0.4%"

DarkRPG.Skill.damage = "0.5%"
DarkRPG.Skill.magazine = "1%"
DarkRPG.Skill.ammo = "5%"
DarkRPG.Skill.critical = "0.25%"
DarkRPG.Skill.firerate = "0.25%"

DarkRPG.Skill.resists = "0.75%"
DarkRPG.Skill.burn = "1.5%"
DarkRPG.Skill.crush = "2%"
DarkRPG.Skill.endurance = "2%"
DarkRPG.Skill.explode = "1.5%"

-- Sets the maximum +bonus% you can get for a player stat on the server.
-- If you put health = '100', your health is 100 + 100 extra health so 200 is the max.
-- If you put evasion = '90%', your evasion is 0 + 90% evasion so 90% evasion is the max.

DarkRPG.Skill.Max.health = '100'
DarkRPG.Skill.Max.movement = '60%'
DarkRPG.Skill.Max.jump = '100%'

DarkRPG.Skill.Max.armor = '100'
DarkRPG.Skill.Max.evasion = '90%'
DarkRPG.Skill.Max.reflect = '50%'

DarkRPG.Skill.Max.salary = '200%'
DarkRPG.Skill.Max.merchant = '50%'
DarkRPG.Skill.Max.prison = '100%'

DarkRPG.Skill.Max.damage = '200%'
DarkRPG.Skill.Max.magazine = "100%"
DarkRPG.Skill.Max.ammo = "500%"
DarkRPG.Skill.Max.critical = '25%'
DarkRPG.Skill.Max.firerate = "35%"

DarkRPG.Skill.Max.resists = '90%'
DarkRPG.Skill.Max.burn = '100%'
DarkRPG.Skill.Max.crush = '100%'
DarkRPG.Skill.Max.endurance = '100%'
DarkRPG.Skill.Max.explode = '100%'

DarkRPG.Skill.Min.health = -0.99
DarkRPG.Skill.Min.movement = -0.99 --Setting to -1 will result in infinite speed.
DarkRPG.Skill.Min.jump = -0.99 --Maximum jumping height bonus, 200 is default in DarkRP

DarkRPG.Skill.Min.armor = 0 --Maximum armor bonus, 100 is default in DarkRP
DarkRPG.Skill.Min.evasion = 0 --Maximum amount of damage that can be dodged, Max is 100%.
DarkRPG.Skill.Min.reflect = 0 --Maximum amount of damage that is reflected back at the attacker, Max is 25%

DarkRPG.Skill.Min.salary = -2 --Maximum bonus to Salary, 0% is default in DarkRP.
DarkRPG.Skill.Min.merchant = -10 --Maximum cost reduction allowed, hard coded to 90% because 100% = free items.
DarkRPG.Skill.Min.prison = -10 --Maximum prison time reduction, 0% is default in DarkRP.

DarkRPG.Skill.Min.damage = -10 --Maximum damage bonus allowed (for all weapons), default is 0% in DarkRP
DarkRPG.Skill.Min.magazine = 0
DarkRPG.Skill.Min.ammo = 0
DarkRPG.Skill.Min.critical = 0
DarkRPG.Skill.Min.firerate = -10

DarkRPG.Skill.Min.resists = -10
DarkRPG.Skill.Min.burn = -10
DarkRPG.Skill.Min.crush = -10
DarkRPG.Skill.Min.endurance = -10
DarkRPG.Skill.Min.explode = -10

