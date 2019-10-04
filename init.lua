
lib_player = {}
lib_player.name = "lib_player"
lib_player.ver_max = 0
lib_player.ver_min = 1
lib_player.ver_rev = 0
lib_player.ver_str = lib_player.ver_max .. "." .. lib_player.ver_min .. "." .. lib_player.ver_rev
lib_player.authorship = "shadmordre, Brandon_Reese"
lib_player.license = "LGLv2.1"
lib_player.copyright = "2019"
lib_player.path_mod = minetest.get_modpath(minetest.get_current_modname())
lib_player.path_world = minetest.get_worldpath()

lib_player.engine_translation = minetest.setting_get("lib_player_engine_translation") or false

local S
local NS
if not lib_player.engine_translation then
	if minetest.get_modpath("intllib") then
		S = intllib.Getter()
	else
		-- S = function(s) return s end
		-- internationalization boilerplate
		S, NS = dofile(lib_player.path_mod.."/intllib.lua")
	end
else
	S = minetest.get_translator(lib_player.name)
end

lib_player.intllib = S

minetest.log(S("[MOD] lib_player:  Loading..."))
minetest.log(S("[MOD] lib_player:  Version:") .. S(lib_player.ver_str))
minetest.log(S("[MOD] lib_player:  Legal Info: Copyright ") .. S(lib_player.copyright) .. " " .. S(lib_player.authorship) .. "")
minetest.log(S("[MOD] lib_player:  License: ") .. S(lib_player.license) .. "")



	lib_player.randomChance = function (percent) 
		--math.randomseed( os.clock() )
		return percent >= ( math.random(1000, 100000) / 1000 )
	end

	lib_player.drop_item = function(pos,itemstack,vel,acc)
		local x = math.random(0, 15)/10 - 0.5
		local z = math.random(0, 15)/10 - 0.5
		--local y = math.random(0, 15)/10 - 2
		local np = { }
		np.x = pos.x + x
		np.z = pos.z + z
		np.y = pos.y + .25
		local obj = minetest.add_item(np, itemstack)
		if obj then
			obj:get_luaentity().collect = true
			if vel ~= nil and acc ~= nil then
				obj:get_luaentity().object:setvelocity(vel)
				obj:get_luaentity().object:setacceleration(acc)
			end
		end
	end



	dofile(lib_player.path_mod.."/gui_init.lua")
	
	dofile(lib_player.path_mod.."/lib_player_functions.lua")
	dofile(lib_player.path_mod.."/cmsg_init.lua")
	
	
	dofile(lib_player.path_mod.."/player_api_init.lua")
	
	dofile(lib_player.path_mod.."/appearance_init.lua")
	dofile(lib_player.path_mod.."/armor_api.lua")
	
	dofile(lib_player.path_mod.."/hud_init.lua")
	
	dofile(lib_player.path_mod.."/hunger_init.lua")

	dofile(lib_player.path_mod.."/thirsty_init.lua")

	dofile(lib_player.path_mod.."/whoison_init.lua")

	dofile(lib_player.path_mod.."/player_data_init.lua")

	dofile(lib_player.path_mod.."/player_stats_init.lua")

	dofile(lib_player.path_mod.."/affects_init.lua")

	dofile(lib_player.path_mod.."/physics_init.lua")

	dofile(lib_player.path_mod.."/energy_init.lua")

	dofile(lib_player.path_mod.."/sprint_init.lua")

	dofile(lib_player.path_mod.."/sickness_init.lua")

	dofile(lib_player.path_mod.."/skills_init.lua")

	dofile(lib_player.path_mod.."/xp_init.lua")
	dofile(lib_player.path_mod.."/proficiencies_init.lua")
	
	dofile(lib_player.path_mod.."/mana_init.lua")
	dofile(lib_player.path_mod.."/magic_init.lua")
	


	dofile(lib_player.path_mod.."/lib_player_register_functions.lua")
	




	minetest.register_on_mods_loaded(function()

	end)



minetest.log(S("[MOD] lib_player:  Successfully loaded."))




























