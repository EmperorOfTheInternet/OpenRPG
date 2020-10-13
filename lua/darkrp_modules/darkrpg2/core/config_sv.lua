DarkRPG = {}
DarkRPG.Server = {}
DarkRPG.Server.Player = {}
DarkRPG.WeaponCategories = {}
DarkRPG.Resists = {}

DarkRPG.Server.Stat_VarNames = { "health", "movement", "jump", "armor", "evasion", "reflect", "salary", "merchant", "prison", "damage", "magazine", "ammo", "critical", "firerate", "resists", "burn", "crush", "endurance", "explode" }

DarkRPG.Server.EquipTimer = 3 -- controls how long you need to wait before items equip, increase if your server lags alot.
DarkRPG.Server.MinimumDelay = 0.03 -- controls the lowest firerate can go regardless of MAX settings, done for server lag concerns.
DarkRPG.Server.CritScale = 1.5 -- controls critical strike damage, 1.5 is 150% damage.

-- Damage resists, based off Garrysmod Wiki's list for damage types
DarkRPG.Resists.List = {}
DarkRPG.Resists.Crush = {
	DMG_FALL,
	DMG_CRUSH,
	DMG_VEHICLE,
	DMG_PHYSGUN,
}
DarkRPG.Resists.Explode = {
	DMG_BLAST,
	DMG_PLASMA,
	DMG_BLAST_SURFACE,
	DMG_SONIC,
}
DarkRPG.Resists.Burn = {
	DMG_BURN,
	268435464, -- ulx admin ignite command!
	DMG_SLOWBURN,
	DMG_ENERGYBEAM,
	DMG_DISSOLVE,
	DMG_SHOCK,
}
DarkRPG.Resists.Endurance = {
	DMG_DROWN,
	DMG_POISON,
	DMG_NERVEGAS,
	DMG_ACID,
	DMG_PARALYZE,
	DMG_RADIATION,
}
for r, resist in pairs( DarkRPG.Resists.Crush ) do
	DarkRPG.Resists.List[resist] = 'crush'
end
for r, resist in pairs( DarkRPG.Resists.Explode ) do
	DarkRPG.Resists.List[resist] = 'explode'
end
for r, resist in pairs( DarkRPG.Resists.Burn ) do
	DarkRPG.Resists.List[resist] = 'burn'
end
for r, resist in pairs( DarkRPG.Resists.Endurance ) do
	DarkRPG.Resists.List[resist] = 'endurance'
end
-- compare all resist to the other resist