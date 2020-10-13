print("<----- Emperor of the Internet Presents... ----->")
print("██████╗  █████╗ ██████╗ ██╗  ██╗██████╗ ██████╗ ██████╗ ")
print("██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝██╔══██╗██╔══██╗██╔════╝ ")
print("██║  ██║███████║██████╔╝█████╔╝ ██████╔╝██████╔╝██║  ███╗")
print("██║  ██║██╔══██║██╔══██╗██╔═██╗ ██╔══██╗██╔═══╝ ██║   ██║")
print("██████╔╝██║  ██║██║  ██║██║  ██╗██║  ██║██║    ╚██████")
print("╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚════╝ ")
print("<--------------- DarkRPG SERVER ---------------->")

print("DarkRPG SERVER: Running 'sv_init.lua'!")
print("DarkRPG SERVER: Retrieving Serverside Files!")

resource.AddWorkshop("677014479")

-- Touching the call order of these files is a fantastic way of crashing your server!
local drpg_run_order = {'core/config_sv','core/functions_sv','core/functions_sh','config/weapons'}
for _, filename in pairs( drpg_run_order ) do
	print("DarkRPG SERVER: Including '"..filename..".lua'!")
	AddCSLuaFile( "darkrp_modules/darkrpg2/"..filename..".lua" )
	include( "darkrp_modules/darkrpg2/"..filename..".lua" )
end

print("DarkRPG SERVER: Finished Loading!")  