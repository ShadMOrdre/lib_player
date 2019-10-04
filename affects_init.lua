affects = {}

affects.affectTime = 15	-- how often, in seconds, should runAffects be called

affectsPath = lib_player.path_mod
affectsFile = minetest.get_worldpath().."/affects.txt"

affects._affects = {}
affects._affectedPlayers = {}
affects._removeOnDieAffects = {}

dofile(affectsPath.."/affects_functions.lua")
dofile(affectsPath.."/affects_api.lua")
dofile(affectsPath.."/affects_loops.lua")
dofile(affectsPath.."/affects_chatcommands.lua")
dofile(affectsPath.."/affects_persistance.lua")

affects.loadAffects()

minetest.register_privilege("affects", "Player can use the affects chat commands.")

minetest.register_on_shutdown(function()
	affects.saveAffects()
end
)

-- TODO on join player apply physics from affects they are affected by