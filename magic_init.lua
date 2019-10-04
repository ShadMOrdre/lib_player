magic = { }
local magicpath = lib_player.path_mod
hud.register("magic", {
	hud_elem_type = "statbar",
	position = {x = 0, y = 1},
	offset = {x=280,y=-120},
	size = { HUD_SB_SIZE },
	text = "hud_magic_fg.png",
	number = 0,
	alignment = {x=-1,y=-1},
	background = "hud_magic_bg.png",
	autohide_bg = true,
	max = 20,
    })


dofile(magicpath.."/magic_api.lua")

function magic.update_magic(player,name)
	if minetest.check_player_privs(name, {immortal=true}) then
		pd.set(name,"mana",20)
		hud.change_item(player,"magic", {number = 20})
		return
	end
	local s = skills.get_skill(name,SKILL_MAGIC)
	local baseAdj = 2
	local mana = pd.get_number(name,"mana")	
		if player_api.get_animation(player) == "lay" then
			baseAdj = baseAdj + 3
		end
		
		if player_api.get_animation(player) == "sit" then
			baseAdj = baseAdj + 1
		end
		
		local adj = baseAdj * ( s.level / 10 )
	
		mana = mana + adj
	
		if mana > 20 then
			mana = 20
		end
		if mana < 0 then
			mana = 0
		end	
	pd.set(name,"mana",mana)
	hud.change_item(player,"magic", {number = mana})
end

-- load magic spells
dofile(magicpath.."/magic_thunder.lua")
dofile(magicpath.."/magic_magicmissle.lua")
dofile(magicpath.."/magic_heal.lua")

lib_player.register_pl_hook(magic.update_magic,4)