
HUD_IW_MAX = 8
HUD_IW_TICK = 0.4
if minetest.is_singleplayer() == true then
	HUD_IW_TICK = 0.2
end

HUD_SB_SIZE = {x = 16, y = 16}

HUD_HEALTH_POS = {x = 0.5,y = 1}
HUD_HEALTH_OFFSET = {x = -262, y = -87}
HUD_AIR_POS = {x = 0.5, y = 1}
HUD_AIR_OFFSET = {x = 15, y = -87}
HUD_HUNGER_POS = {x = 0.5, y = 1}
HUD_HUNGER_OFFSET = {x = 15, y = -110}
HUD_ARMOR_POS = {x = 0.5, y = 1}
HUD_ARMOR_OFFSET = {x = -262, y = -110}

-- Reorder everything when using ItemWeel
hud.item_wheel = minetest.setting_getbool("hud_item_wheel")
if hud.item_wheel then
	HUD_HEALTH_POS = {x = 0.5,y = 1}
	HUD_HEALTH_OFFSET = {x = -385, y = -77}
	HUD_AIR_POS = {x = 0.5, y = 1}
	HUD_AIR_OFFSET = {x = 150, y = -77}
	HUD_HUNGER_POS = {x = 0.5, y = 1}
	HUD_HUNGER_OFFSET = {x = 180, y = -44}
	HUD_ARMOR_POS = {x = 0.5, y = 1}
	HUD_ARMOR_OFFSET = {x = -415, y = -44}
end

-- read hud.conf settings
function hud.read_conf()
	local mod_path = lib_player.path_mod
	local set = io.open(mod_path .. "/hud.conf", "r")
	if set then
		dofile(mod_path .. "/hud.conf")
		set:close()
	end
end

hud.read_conf()

local damage_enabled = minetest.setting_getbool("enable_damage")

hud.show_hunger = minetest.get_modpath("hunger") ~= nil
--hud.show_armor = minetest.get_modpath("3d_armor") ~= nil
hud.show_armor = minetest.get_modpath("lib_armor") ~= nil

-- check if some settings are invalid
local enable_hunger = minetest.setting_getbool("hud_hunger_enable")
if (enable_hunger == true or HUD_ENABLE_HUNGER == true) and not hud.show_hunger then
	hud.notify_hunger(5)
end

if damage_enabled ~= true then
	hud.show_armor = false
	return
end

hud.register("health", {
	hud_elem_type = "statbar",
	position = HUD_HEALTH_POS,
	size = HUD_SB_SIZE,
	text = "hud_heart_fg.png",
	number = 20,
	alignment = {x = -1, y = -1},
	offset = HUD_HEALTH_OFFSET,
	background = "hud_heart_bg.png",
	events = {
		{
			type = "damage",
			func = function(player)
				hud.change_item(player, "health", {number = player:get_hp()})
			end
		}
	},
})

hud.register("air", {
	hud_elem_type = "statbar",
	position = HUD_AIR_POS,
	size = HUD_SB_SIZE,
	text = "hud_air_fg.png",
	number = 0,
	alignment = {x = -1, y = -1},
	offset = HUD_AIR_OFFSET,
	background = nil,
	events = {
		{
			type = "breath",
			func = function(player)
				if not player then return end -- ADDED
				local air = player:get_breath() or 11
				if air > 10 then
					air = 0
				end
				hud.change_item(player, "air", {number = air * 2})
			end
		}
	},
})

hud.register("armor", {
	hud_elem_type = "statbar",
	position = HUD_ARMOR_POS,
	size = HUD_SB_SIZE,
	text = "hud_armor_fg.png",
	number = 0,
	alignment = {x = -1, y = -1},
	offset = HUD_ARMOR_OFFSET,
	background = "hud_armor_bg.png",
	autohide_bg = true,
	max = 20,
})

hud.register("hunger", {
	hud_elem_type = "statbar",
	position = HUD_HUNGER_POS,
	size = HUD_SB_SIZE,
	text = "hud_hunger_fg.png",
	number = 0,
	alignment = {x = -1, y = -1},
	offset = HUD_HUNGER_OFFSET,
	background = "hud_hunger_bg.png",
	max = 0,
})
--[[

hud.register("cmsg_bg", {
	hud_elem_type = "statbar",
	position = {x=1, y=1},
	size = { x=115, y=60 },
	text = "",
	number = 1,
	alignment = {x = -1, y = -1},
	offset = { x = -520, y = -60 },
	background = "panel_box_bg.png",
	max = 1,
})

hud.register("quests_bg", {
	hud_elem_type = "statbar",
	position = {x=1, y=1},
	size = { x=240, y=60 },
	text = "",
	number = 1,
	alignment = {x = -1, y = -1},
	offset = { x = -520, y = -120 },
	background = "panel_bg.png",
	max = 1,
})

--]]

























