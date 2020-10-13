print("<----- Emperor of the Internet Presents... ----->")
print("██████╗  █████╗ ██████╗ ██╗  ██╗██████╗ ██████╗ ██████╗ ")
print("██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝██╔══██╗██╔══██╗██╔════╝ ")
print("██║  ██║███████║██████╔╝█████╔╝ ██████╔╝██████╔╝██║  ███╗")
print("██║  ██║██╔══██║██╔══██╗██╔═██╗ ██╔══██╗██╔═══╝ ██║   ██║")
print("██████╔╝██║  ██║██║  ██║██║  ██╗██║  ██║██║    ╚██████")
print("╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚════╝ ")
print("<--------------- DarkRPG CLIENT ---------------->")

print("DarkRPG CLIENT: Running 'cl_init.lua'!")
print("DarkRPG CLIENT: Sending Clientside Files!")

-- Touching the call order of these files is a fantastic way of crashing your server!
local drpg_run_order = {'core/config_cl','config/config','language/default','core/functions_cl','core/functions_sh','config/weapons','core/frame', 'config/donator'}
for _, filename in pairs( drpg_run_order ) do
	print("DarkRPG CLIENT: Including '"..filename..".lua'!")
	AddCSLuaFile( "darkrp_modules/darkrpg2/"..filename..".lua" )
	include( "darkrp_modules/darkrpg2/"..filename..".lua" )
end

print("DarkRPG CLIENT: Finished Loading!")  