local S
if core.get_modpath("intllib") then
    S = intllib.Getter()
else
    S = function(s,a,...)a={a,...}return s:gsub("@(%d+)",function(n)return a[tonumber(n)]end)end
end

advtrains.register_wagon("rocket", {
	mesh="advtrains_rocket.b3d",
	textures = {"advtrains_rocket.png"},
	is_locomotive=true,
	drives_on={default=true},
	max_speed=5,
	seats = {
		{
			name=S("Driver Stand"),
			attach_offset={x=0, y=10, z=-10},
			view_offset={x=0, y=6, z=0},
			driving_ctrl_access=true,
			group = "dstand",
		},
	},
	seat_groups = {
		dstand={
			name = "Driver Stand",
			access_to = {},
		},
	},
	assign_to_seat_group = {"dstand"},
	visual_size = {x=1, y=1},
	wagon_span=1.6,
	collisionbox = {-1.0,-0.5,-1.0, 1.0,2.5,1.0},
	update_animation=function(self, velocity)
		if self.old_anim_velocity~=advtrains.abs_ceil(velocity) then
			self.object:set_animation({x=1,y=80}, advtrains.abs_ceil(velocity)*15, 0, true)
			self.old_anim_velocity=advtrains.abs_ceil(velocity)
		end
	end,
	custom_on_activate = function(self, staticdata_table, dtime_s)
		core.add_particlespawner({
			amount = 20,
			time = 0,
		--  ^ If time is 0 has infinite lifespan and spawns the amount on a per-second base
			minpos = {x=0, y=3.2, z=1.4},
			maxpos = {x=0, y=3.2, z=1.4},
			minvel = {x=-0.2, y=1.8, z=-0.2},
			maxvel = {x=0.2, y=2, z=0.2},
			minacc = {x=0, y=-0.1, z=0},
			maxacc = {x=0, y=-0.3, z=0},
			minexptime = 2,
			maxexptime = 4,
			minsize = 2,
			maxsize = 8,
		--  ^ The particle's properties are random values in between the bounds:
		--  ^ minpos/maxpos, minvel/maxvel (velocity), minacc/maxacc (acceleration),
		--  ^ minsize/maxsize, minexptime/maxexptime (expirationtime)
			collisiondetection = true,
		--  ^ collisiondetection: if true uses collision detection
			vertical = false,
		--  ^ vertical: if true faces player using y axis only
			texture = "smoke_puff.png",
		--  ^ Uses texture (string)
			attached = self.object,
		})
	end,
	drops={"advtrains:rocket"},
}, S("Rocket"), "advtrains_rocket_inv.png")






advtrains.register_wagon("rocket_wagon_tender", {
	mesh="advtrains_rocket_wagon.b3d",
	textures = {"advtrains_rocket_wagon.png"},
	drives_on={default=true},
	max_speed=3,
	seats = {},
	visual_size = {x=1, y=1},
	wagon_span=1.0,
	collisionbox = {-1.0,-0.5,-1.0, 1.0,1.5,1.0},
	drops={"default:steelblock 4"},
	has_inventory = true,
	get_inventory_formspec = function(self)
		return "size[8,11]"..
			"list[detached:advtrains_wgn_"..self.unique_id..";box;0,0;8,6;]"..
			"list[current_player;main;0,7;8,4;]"..
			"listring[]"
	end,
	inventory_list_sizes = {
		box=8*2,
	},
}, S("Rocket tender"), "advtrains_wagon_rocket_tender_inv.png")



advtrains.register_wagon("rocket_wagon_box", {
	mesh="advtrains_rocket_wagon_long.b3d",
	textures = {"advtrains_rocket_wagon.png"},
	drives_on={default=true},
	max_speed=3,
	seats = {},
	visual_size = {x=1, y=1},
	wagon_span=1.9,
	collisionbox = {-1.0,-0.5,-1.0, 1.0,1.5,1.0},
	drops={"default:steelblock 4"},
	has_inventory = true,
	get_inventory_formspec = function(self)
		return "size[8,11]"..
			"list[detached:advtrains_wgn_"..self.unique_id..";box;0,0;8,6;]"..
			"list[current_player;main;0,7;8,4;]"..
			"listring[]"
	end,
	inventory_list_sizes = {
		box=8*6,
	},
}, S("Rocket Box Wagon"), "advtrains_wagon_rocket_box_inv.png")


--craftings for train

core.register_craft({
	output = 'advtrains:rocket',
	recipe = {
		{'advtrains:chimney', '', ''},
		{'advtrains:chimney', 'advtrains:boiler', 'group:wood'},
		{'advtrains:wheel', '', 'advtrains:wheel'},
	},
})

core.register_craft({
	output = 'advtrains:rocket_wagon_tender',
	recipe = {
		{'', '', 'advtrains_train_rocket:barrel'},
		{'group:wood', 'group:wood', 'group:wood'},
		{'advtrains:wheel', '', 'advtrains:wheel'},
	},
})

core.register_craft({
	output = 'advtrains:rocket_wagon_tender',
	recipe = {
		{'advtrains_train_rocket:barrel_stack', 'advtrains_train_rocket:barrel_stack', 'advtrains_train_rocket:barrel_stack'},
		{'group:wood', 'group:wood', 'group:wood'},
		{'advtrains:wheel', '', 'advtrains:wheel'},
	},
})

--barrels for craftings and decoration

local barrel_formspec =
	"size[8,9]" ..
	default.gui_bg ..
	default.gui_bg_img ..
	default.gui_slots ..
	"list[current_name;main;0,0.3;8,4;]" ..
	"list[current_player;main;0,4.85;8,1;]" ..
	"list[current_player;main;0,6.08;8,3;8]" ..
	"listring[current_name;main]" ..
	"listring[current_player;main]" ..
	default.get_hotbar_bg(0,4.85)

core.register_node("advtrains_train_rocket:barrel", {
	description = "barrel",
	tiles = {"advtrains_rocket_wagon.png"},
	groups = {choppy = 3, oddly_breakable_by_hand = 3, flammable = 3,},
	drawtype = "mesh",
    paramtype2 = "facedir",
	mesh = "advtrains_barrel.b3d",
    visual_scale = 0.4,
	paramtype = "light",
    sounds = default.node_sound_wood_defaults(),
          
    on_construct = function(pos)
		local meta = core.get_meta(pos)
		meta:set_string("formspec", barrel_formspec)
		local inv = meta:get_inventory()
		inv:set_size("main", 8*1)
	end,
	can_dig = function(pos,player)
		local meta = core.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		core.log("action", player:get_player_name() ..
			" moves stuff in chest at " .. core.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		core.log("action", player:get_player_name() ..
			" moves " .. stack:get_name() ..
			" to chest at " .. core.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		core.log("action", player:get_player_name() ..
			" takes " .. stack:get_name() ..
			" from chest at " .. core.pos_to_string(pos))
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "main", drops)
		drops[#drops+1] = "advtrains_train_rocket:barrel"
		core.remove_node(pos)
		return drops
	end,
})

core.register_node("advtrains_train_rocket:barrel_stack", {
	description = "stacked barrel",
	tiles = {"advtrains_rocket_wagon.png"},
	groups = {choppy = 3, oddly_breakable_by_hand = 3, flammable = 3,},
	drawtype = "mesh",
    paramtype2 = "facedir",
	mesh = "advtrains_barrel_stack.b3d",
    visual_scale = 0.4,
	paramtype = "light",
    sounds = default.node_sound_wood_defaults(),
    selection_box = {
		type = "fixed",
		fixed = {
				{-1.0, -0.5, -0.5, 1.0, 1.25, 0.5},
        },
    },
    collision_box = {
		type = "fixed",
		fixed = {
				{-1.5, -0.5, -0.5, 0.5, 1.25, 0.5},
        },
    },
          
    on_construct = function(pos)
		local meta = core.get_meta(pos)
		meta:set_string("formspec", barrel_formspec)
		local inv = meta:get_inventory()
		inv:set_size("main", 8*3)
	end,
	can_dig = function(pos,player)
		local meta = core.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		core.log("action", player:get_player_name() ..
			" moves stuff in chest at " .. core.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		core.log("action", player:get_player_name() ..
			" moves " .. stack:get_name() ..
			" to chest at " .. core.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		core.log("action", player:get_player_name() ..
			" takes " .. stack:get_name() ..
			" from chest at " .. core.pos_to_string(pos))
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "main", drops)
		drops[#drops+1] = "advtrains_train_rocket:barrel_stack"
		core.remove_node(pos)
		return drops
	end,
})

--craftings for barrels
core.register_craft({
	output = 'advtrains_train_rocket:barrel',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'default:steel_ingot','','default:steel_ingot'},
		{'group:wood', 'group:wood', 'group:wood'},
	},
})
core.register_craft({
	output = 'advtrains_train_rocket:barrel_stack',
	recipe = {
		{'', 'advtrains_train_rocket:barrel', ''},
		{'group:stick', 'group:stick', 'group:stick'},
		{'advtrains_train_rocket:barrel', '', 'advtrains_train_rocket:barrel'},
	},
})

    
