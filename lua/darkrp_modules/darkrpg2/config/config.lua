--------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------- DarkRPG Config File and Documentation ---------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

-- DETAILED INSTRUCTIONS ON HOW TO USE 'DarkRPG2' IS AT THIS GOOGLE DOC!
-- https://docs.google.com/document/d/1dqLyZUZ7HouEbp7okLxJaGqeHVtdl__f6j2S0pt2aPg/edit?usp=sharing

--------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------- Visual Settings --------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

DarkRPG.GUI.Height = 468 -- Default Height, minimum is 300 pixels
DarkRPG.GUI.Width = 353 -- Default Width, minimum is 300 pixels or how big your talent button images are (below)
DarkRPG.GUI.ToggleKey = KEY_F2 -- Toggle Key, KEY_F3 causes weird issues, make nil to turn off
DarkRPG.Config.HUDStyle = "PlainHUD" -- comes with 'PlainHUD', 'MaterialHUD' and 'FlatHUD', you can make your own in the '/hud/' folder.
DarkRPG.Config.HitNumbers = true -- displays Hit Numbers with 'Critical!', 'Evade!' and 'Reflect!' specifically for DarkRPG2.
DarkRPG.Config.DisplayErrors = true -- Displays clientside errors and warnings about your talent trees, will tell you what is wrong and how to fix it.
DarkRPG.Config.DelayToReset = 20 -- Time between hitting confirms, setting to 0 is not recommended, it'll allow people to spam/ddos your server so 5 seconds is recommended.

--------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- Gamemode and File Settings --------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

-- IF YOU MAKE NEW TALENT TREE FILES OR WANT TO TURN THEM ON / OFF, USE THIS!
-- This is referencing files inside the 'darkrpg2/jobs/' folder, do not include the '.lua' here
DarkRPG.Config.IncludeJobFiles = {
	"cit-med-gun-mayor",
	"criminals",
	"hobo",
	"police",
	"sharedtalents",
	--"template-example",
}

-- If you do not have 'vrondakis leveling system' or don't want leveling, turn this to true
-- if true, the number of talent points and skill points you get is determined by 'MaximumTalentPoints' and 'MaximumSkillPoints'
-- if false, the number of talent points and skill points you get is determined by your level
DarkRPG.Config.NoLevelingMode = false

-- 'english', 'spanish', 'german', 'french', russian' do not include '.lua'
DarkRPG.Config.Language = "english"

DarkRPG.Config.popupMenuOnJoin = false

-- By request, added sound effects to the menu, player level up, and equip, etc.
-- The syntax is {Sound('Your_Sound_File.wav'), SoundPitch, SoundVolume}, 100 is default, 0 is off, over a 100 is louder or squeakier
-- To turn off sounds for a particular menu item, just do 'OpenMenuSound = nil' and it'll skip playing that particular sound.
DarkRPG.Config.PlaySounds = false -- turned off by default
DarkRPG.Config.OpenMenuSound = { Sound('items/ammocrate_open.wav'), 100, 100 }
DarkRPG.Config.CloseMenuSound = { Sound('items/ammocrate_close.wav'), 100, 100 }
DarkRPG.Config.StatTalentHoverSound = { Sound('npc/metropolice/vo/on1.wav'), 100, 100 }
DarkRPG.Config.HeaderTitleSound = { Sound('npc/metropolice/vo/on2.wav'), 100, 100 }
DarkRPG.Config.PlayerLevelUpSound = { Sound('items/suitchargeok1.wav'), 100, 100 }
-- Note these sounds suck, import your own modded ones, like the Starcraft: Brood War menu sounds, Star Wars sounds, World of Warcraft sounds, the BRIIIIING level up noise from Everquest 1

--------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------- Talent Points ---------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

DarkRPG.Config.TalentPointsOn = true -- if false, the talent tree does not appear and can't be used.
DarkRPG.Config.MaximumTalentPoints = 26 -- The maximum talent points you can have, default is you get 26 points even if you're level 1000.
DarkRPG.Config.NextTierMinimum = 5 -- How many talents are needed to go to the next row of talents, 0 lets you pick any talent on the tree.
DarkRPG.Config.TalentPointsPerLevel = 1 -- How many talent points you gain per level. You can set 0.5 for 1 every 2 levels.
DarkRPG.Config.TalentWidth = 4 -- How many talent boxes are on a row, this affects the x on 'pos = {x,y}'' for talents
DarkRPG.Config.TalentButtonSize = 64 -- How large the talents are in pixels, 64x64 by default
DarkRPG.Config.TalentPadding = 6 -- How far apart the talent buttons are in pixels, 6 pixels padding by default

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- Skill Points ---------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

DarkRPG.Config.SkillPointsOn = true -- if false, the stat menu appears, but you can't add skill points anymore.
DarkRPG.Config.MaximumSkillPoints = 150 -- The maximum skill points you can have, default is you get 150 points even if you're level 1000.
DarkRPG.Config.SkillPointsPerLevel = 3 -- The number of skill points you gain per level.
DarkRPG.Config.SkillShiftClick = 10 -- How many skill points are added per Shift+Left Click

-- How much of a bonus a skill point gives to a player stat
-- health = '1' is +1 health per skill point.

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

--------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------- VIP Groups ----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

-- If you want a custom vipCheck for VIP skills, change this value, it MUST return either true or false, advanced users only!
-- group is the 'group = {'admin','superadmin','stuff'}' you set in the talent.

function DarkRPG.vipCheck( group )
	if group == nil or group == {} then return end

	for k, vip in pairs( group ) do
		if LocalPlayer():GetNWString("usergroup") == vip		--FAdmin Default Admin Mod Installed with DarkRP
		or LocalPlayer():GetUserGroup()							--ULX Admin Mod check for "donator"
		or LocalPlayer():GetNWString("EV_UserGroup") == vip		--Evolve Admin Mod Syntax
		then
			return true
		end
	end
	return (LocalPlayer():IsAdmin() or LocalPlayer():IsSuperAdmin()) --Check if players are admins.
end

--------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------- Other Settings --------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

-- Advanced users can go into config_cl.lua and config_sv.lua to change certain values
-- I STRONGLY recommend changing only these values, other ones can break the whole thing

-- These values are the only values I recommend tweaking, located inside 'config_sv.lua'

-- DarkRPG.Server.EquipTimer
-- DarkRPG.Server.MinimumDelay
-- DarkRPG.Server.CritScale