local S
if minetest.get_modpath("intllib") then
    S = intllib.Getter()
else
    S = function(s,a,...)a={a,...}return s:gsub("@(%d+)",function(n)return a[tonumber(n)]end)end
end

advtrains.register_wagon("engine_BBOE_1080", {
	mesh="advtrains_engine_BBOE_1080.b3d",
	textures = {"advtrains_engine_BBOE_1080.png"},
	drives_on={default=true},
	max_speed=20,
	seats = {
		{
			name=S("Driver stand"),
			attach_offset={x=0, y=8, z=13},
			view_offset={x=0, y=0, z=0},
			driving_ctrl_access=true,
			group="dstand",
		},
		{
			name="1",
			attach_offset={x=-4, y=8, z=0},
			view_offset={x=0, y=0, z=0},
			group="pass",
		},
		{
			name="2",
			attach_offset={x=4, y=8, z=0},
			view_offset={x=0, y=0, z=0},
			group="pass",
		},
		{
			name="3",
			attach_offset={x=-4, y=8, z=-8},
			view_offset={x=0, y=0, z=0},
			group="pass",
		},
		{
			name="4",
			attach_offset={x=4, y=8, z=-8},
			view_offset={x=0, y=0, z=0},
			group="pass",
		},
	},
	seat_groups = {
		dstand={
			name = "Driver Stand",
			access_to = {"pass"},
			require_doors_open=true,
		},
		pass={
			name = "Engenier's area",
			access_to = {"dstand"},
			require_doors_open=true,
		},
	},
	assign_to_seat_group = {"dstand"},
	doors={
		open={
			[-1]={frames={x=0, y= 20}, time=1},
			[1]={frames={x=40, y=60}, time=1}
		},
		close={
			[-1]={frames={x=20, y=40}, time=1},
			[1]={frames={x=60, y=80}, time=1}
		}
	},
	door_entry={-1},
	visual_size = {x=1, y=1},
	wagon_span=3.0,
	is_locomotive=true,
	collisionbox = {-1.0,-0.5,-1.0, 1.0,2.5,1.0},
	drops={"advtrains_engine_BBÖ_1080"},
}, S("BBÖ 1080 "), "advtrains_engine_BBOE_1080_inv.png")
minetest.register_craft({
	output = 'advtrains:engine_BBOE_1080',
	recipe = {
		{'default:steelblock', 'default:steelblock', 'default:steelblock'},
		{'dye:dark_green', 'dye:dark_green', 'dye:dark_green'},
		{'default:steelblock', 'dye:dark_green', 'default:steelblock'},
	},
})
advtrains.register_wagon("wagon_ware", {
	mesh="advtrains_wagon_BBOE_ware.b3d",
	textures = {"advtrains_wagon_BBOE_ware.png"},
	drives_on={default=true},
	max_speed=10,
	seats = {},
	visual_size = {x=1, y=1},
	wagon_span=2.8,
	collisionbox = {-1.0,-0.5,-1.0, 1.0,2.5,1.0},
	drops={"advtrains:wagon_coal"},
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
}, S("Ware Wagon(BBÖ)"), "advtrains_wagon_BBOE_ware_inv.png")
minetest.register_craft({
	output = 'advtrains:wagon_BBOE_ware',
	recipe = {
		{'default:steelblock', 'default:steelblock', 'default:steelblock'},
		{'default:steelblock', 'dye:dark_brown', 'default:steelblock'},
		{'default:steelblock', 'dye:dark_brown', 'default:steelblock'},
	},
})

