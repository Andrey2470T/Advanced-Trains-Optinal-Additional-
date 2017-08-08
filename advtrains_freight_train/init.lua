local S
if minetest.get_modpath("intllib") then
    S = intllib.Getter()
else
    S = function(s,a,...)a={a,...}return s:gsub("@(%d+)",function(n)return a[tonumber(n)]end)end
end


advtrains.register_wagon("diesel_lokomotive", {
	mesh="advtrains_engine_diesel.b3d",
	textures = {"advtrains_engine_diesel.png"},
	is_locomotive=true,
	drives_on={default=true},
	max_speed=10,
	seats = {
		{
			name=S("Driver Stand (left)"),
			attach_offset={x=-3, y=12, z=-2},
			view_offset={x=0, y=3, z=0},
			driving_ctrl_access=true,
			group = "dstand",
		},
-- 		{
-- 			name=S("Driver Stand (right)"),
-- 			attach_offset={x=5, y=10, z=-10},
-- 			view_offset={x=0, y=6, z=0},
-- 			driving_ctrl_access=true,
-- 			group = "dstand",
-- 		},
	},
	seat_groups = {
		dstand={
			name = "Driver Stand",
			access_to = {},
		},
	},
	assign_to_seat_group = {"dstand"},
	visual_size = {x=1, y=1},
	wagon_span=1.85,
	collisionbox = {-1.0,-0.5,-1.0, 1.0,2.5,1.0},
	update_animation=function(self, velocity)
		if self.old_anim_velocity~=advtrains.abs_ceil(velocity) then
			self.object:set_animation({x=1,y=80}, advtrains.abs_ceil(velocity)*15, 0, true)
			self.old_anim_velocity=advtrains.abs_ceil(velocity)
		end
	end,
	custom_on_activate = function(self, staticdata_table, dtime_s)
		minetest.add_particlespawner({
			amount = 10,
			time = 0,
		--  ^ If time is 0 has infinite lifespan and spawns the amount on a per-second base
			minpos = {x=0, y=2, z=1.2},
			maxpos = {x=0, y=2, z=1.2},
			minvel = {x=-0.2, y=1.8, z=-0.2},
			maxvel = {x=0.2, y=2, z=0.2},
			minacc = {x=0, y=-0.1, z=0},
			maxacc = {x=0, y=-0.3, z=0},
			minexptime = 2,
			maxexptime = 4,
			minsize = 1,
			maxsize = 4,
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
	drops={"advtrains:engine_diesel"},
}, S("diesel Engine"), "advtrains_engine_diesel_inv.png")

minetest.register_craft({
	output = 'advtrains:diesel_lokomotive',
	recipe = {
		{'default:steelblock', 'dye:grey', 'default:steelblock'},
		{'dye:cyan', 'dye:grey', 'dye:cyan'},
		{'default:steelblock', 'dye:cyan', 'default:steelblock'},
	},
})

advtrains.register_wagon("wagon_gravel", {
	mesh="advtrains_wagon_gravel.b3d",
	textures = {"advtrains_wagon_gravel.png"},
	drives_on={default=true},
	max_speed=10,
	seats = {},
	visual_size = {x=1, y=1},
	wagon_span=1.6,
	collisionbox = {-1.0,-0.5,-1.0, 1.0,1.5,1.0},
	drops={"advtrains:wagon_gravel"},
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
}, S("gravel Wagon"), "advtrains_wagon_gravel_inv.png")

minetest.register_craft({
	output = 'advtrains:wagon_gravel',
	recipe = {
		{'group:wood', 'dye:grey', 'default:steelblock'},
		{'dye:red', 'dye:grey', 'dye:red'},
		{'default:steelblock', 'dye:red', 'group:wood'},
	},
})

advtrains.register_wagon("wagon_track", {
	mesh="advtrains_wagon_stick.b3d",
	textures = {"advtrains_wagon_stick.png"},
	drives_on={default=true},
	max_speed=10,
	seats = {},
	visual_size = {x=1, y=1},
	wagon_span=1.6,
	collisionbox = {-1.0,-0.5,-1.0, 1.0,1.5,1.0},
	drops={"advtrains:wagon_track"},
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
}, S("track wagon"), "advtrains_wagon_track_inv.png")

minetest.register_craft({
	output = 'advtrains:wagon_track',
	recipe = {
		{'group:wood', 'dye:black', 'default:steelblock'},
		{'dye:red', 'dye:black', 'dye:red'},
		{'default:steelblock', 'dye:red', 'group:wood'},
	},
})


advtrains.register_wagon("wagon_lava", {
	mesh="advtrains_wagon_lava.b3d",
	textures = {"advtrains_wagon_lava.png"},
	drives_on={default=true},
	max_speed=10,
	seats = {},
	visual_size = {x=1, y=1},
	wagon_span=1.6,
	collisionbox = {-1.0,-0.5,-1.0, 1.0,1.5,1.0},
	drops={"advtrains:wagon_lava"},
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
}, S("lava wagon"), "advtrains_wagon_lava_inv.png")

minetest.register_craft({
	output = 'advtrains:wagon_lava',
	recipe = {
		{'group:wood', 'dye:black', 'group:wood'},
		{'dye:orange', 'default:lava_source', 'dye:orange'},
		{'group:wood', 'dye:orange', 'group:wood'},
	},
})

advtrains.register_wagon("wagon_tree", {
	mesh="advtrains_wagon_tree.b3d",
	textures = {"advtrains_wagon_tree.png"},
	drives_on={default=true},
	max_speed=10,
	seats = {},
	visual_size = {x=1, y=1},
	wagon_span=1.6,
	collisionbox = {-1.0,-0.5,-1.0, 1.0,1.5,1.0},
	drops={"advtrains:wagon_tree"},
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
}, S("tree wagon"), "advtrains_wagon_tree_inv.png")

minetest.register_craft({
	output = 'advtrains:wagon_tree',
	recipe = {
		{'group:wood', 'dye:black', 'group:wood'},
		{'group:tree', 'dye:black', 'group:tree'},
		{'group:wood', 'dye:black', 'group:wood'},
	},
})
