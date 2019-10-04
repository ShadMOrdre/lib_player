STAT_DUG = 1
STAT_PLACED = 2
STAT_DIED = 3
STAT_TRAVEL = 4
STAT_PK = 5
STAT_KILLS = 6

local player_data = {}
local player_dir = minetest.get_worldpath() .. "/"

pd = {}

function pd.serialize_to_file(filename,t)
	local f = io.open(filename, "w")
	if f ~= nil then
		f:write(minetest.serialize(t))
		f:close()
	else
		minetest.log("error","Unable to open for writing "..tostring(filename))
	end
end

function pd.deserialize_from_file(filename)
	local f = io.open(filename, "r")
		if f==nil then 
			--minetest.log("error","File "..filename.." not found, returning empty table")
			return {}
		end
			local t = f:read("*all")
			f:close()
		if t=="" or t==nil then 
			--minetest.log("error","File "..filename.." is blank, returning empty table")
			return {}
		end
		return minetest.deserialize(t)
end

pd.is_online = function(name)
	if player_data[name] ~= nil then
		return true
	else	
		return false
	end
end

pd.load_player = function(name)	
	if player_data[name] == nil then	-- prevent loading the player twice... specifically when a new player joins 
		player_data[name] = pd.deserialize_from_file(player_dir..name..".data")
	end	
end

pd.unload_player = function(name)
	pd.save_player(name)
	player_data[name] = nil
end

pd.save_player = function(name)
	if player_data[name] ~= nil then
		pd.serialize_to_file(player_dir..name..".data",player_data[name])
	end
end

pd.save_all = function(again)
	minetest.log("action","Saving player data...")
	for name,_ in pairs(player_data) do
		if player_data[name] ~= nil then
			pd.save_player(name)
		end
	end
	if again == true then
		minetest.after(300,pd.save_all,true)
	end
end

pd.get = function(name,param)
	if pd.validate(name,param) then
		return player_data[name][param]
	else
		return nil
	end
end

pd.get_number = function(name,param)
	return tonumber(pd.get(name,param)) or 0
end

pd.set = function(name, param, value)
	if pd.validate(name,param) then
		player_data[name][param] = value
	else
		minetest.log("error","Unable to set "..tostring(param).." to "..tostring(value)) 
	end
end

pd.unset = function(name, param)
	pd.set(name,param,nil)
end

pd.increment = function (name, param, amount)
	local val = pd.get_number(name,param)  + amount
	pd.set(name,param,val)
end

pd.validate = function (name,param)
	if name ~= nil and param ~= nil then
		if player_data[name] ~= nil then
			return true
		else
			return false
		end
	else
		return false
	end
end

pd.dump = function()
	--default.tprint(player_data,4)
end

minetest.after(300,pd.save_all,true)



local function on_join(player)	
	pd.load_player(player:get_player_name())
	local name = player:get_player_name()
--	if minetest.setting_getbool("enable_damage") then
--		hunger_join_player(player)
--	end
	-- for backward compatibility if player was created before max hp was added
	if pd.get_number(name,"max_hp") == 0 then
		local l = pd.get(name,"level")
		local hp = 6 + (( math.floor(l.level / 2) ) * 2)
		if hp > 20 then
			hp = 20
		end
		pd.set(name,"max_hp",hp)
	end
end
minetest.register_on_joinplayer(on_join)

local function on_leave(player)
	local name = player:get_player_name()
	pd.unload_player(name)
end
minetest.register_on_leaveplayer(on_leave)

local function on_new(player)
--	local hud_id = player:hud_add({
--		hud_elem_type = "image",
--		position = {x = 0.5, y = 0.5},
--		scale = {
--			x = -100,
--			y = -100
--		},
--		text = "adventuretest_spawning_hud.png"
--	})

	local name = player:get_player_name()
	pd.load_player(name)
	-- set some defaults
	pd.set(name,"energy",20)
	pd.set(name,"stamina",0)
	pd.set(name,"mana",20)
	pd.set(name,"hunger_lvl",20)
	pd.set(name,"hunger_exhaus",0)
	pd.set(name,"speed",1)
	pd.set(name,"jump",1)
	pd.set(name,"gravity",1)
	pd.set(name,"level", {level=1,exp=0})
	pd.set(name,"max_health",6)

	pd.set(name,"species",1)
	pd.set(name,"class",1)
	pd.set(name,"health",1)
	pd.set(name,"hit_points",1)
	pd.set(name,"constitution",1)
	pd.set(name,"dexterity",1)
	pd.set(name,"aptitude",1)
	pd.set(name,"intelligence",1)
	pd.set(name,"charmisma",1)
	pd.set(name,"charm",1)
	pd.set(name,"experience",1)
	pd.set(name,"skill_dawnage",1)
	pd.set(name,"skill_stoneage",1)
	pd.set(name,"skill_bronzeage",1)
	pd.set(name,"skill_ironage",1)
	pd.set(name,"skill_industrialage",1)
	pd.set(name,"skill_industrialage",1)
	pd.set(name,"skill_spaceage",1)
	pd.set(name,"proficiency_pick",1)
	pd.set(name,"proficiency_shovel",1)
	pd.set(name,"proficiency_axe",1)
	pd.set(name,"proficiency_hoe",1)
	pd.set(name,"proficiency_bow",1)
	pd.set(name,"proficiency_longbow",1)
	pd.set(name,"proficiency_crossbow",1)
	pd.set(name,"proficiency_longsword",1)
	pd.set(name,"proficiency_shortsword",1)
	pd.set(name,"proficiency_daggar",1)
	pd.set(name,"proficiency_largebattleaxe",1)
	pd.set(name,"proficiency_battleaxe",1)
	pd.set(name,"proficiency_throwingaxe",1)
	pd.set(name,"proficiency_warhammer",1)
	pd.set(name,"proficiency_halberd",1)
	pd.set(name,"proficiency_mace",1)
	pd.set(name,"proficiency_pike",1)
	pd.set(name,"proficiency_sling",1)
	pd.set(name,"proficiency_slingshot",1)
	pd.set(name,"proficiency_spear",1)
	pd.set(name,"proficiency_javelin",1)
	pd.set(name,"proficiency_club",1)
	pd.set(name,"proficiency_knife",1)
	pd.set(name,"proficiency_chisel",1)
	pd.set(name,"proficiency_scissors",1)
	pd.set(name,"proficiency_lockpick",1)
	pd.set(name,"proficiency_hammer",1)
	pd.set(name,"proficiency_saw",1)
	pd.set(name,"proficiency_scythe",1)
	pd.set(name,"proficiency_repair",1)
	pd.set(name,"proficiency_construct",1)
	pd.set(name,"proficiency_recycle",1)
	pd.set(name,"proficiency_farm",1)
	pd.set(name,"proficiency_forge",1)
	pd.set(name,"proficiency_research",1)
	pd.set(name,"proficiency_explore",1)
	pd.set(name,"proficiency_mine",1)
	pd.set(name,"proficiency_brew",1)
	pd.set(name,"proficiency_cast",1)
	pd.set(name,"proficiency_summon",1)
	player:set_hp(6)
	skills.set_default_skills(name)
	pd.save_player(name)
	pd.set(name,"spawning_hud",hud_id)
	pd.set(name,"timeofday",minetest.get_timeofday())
	pd.set(name,"currentday",0)
	--minetest.after(3,adventuretest.check_spawn,player)
end
minetest.register_on_newplayer(on_new)


local function on_shutdown()
	pd.save_all()
end
minetest.register_on_shutdown(on_shutdown)



