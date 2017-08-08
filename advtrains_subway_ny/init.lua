local S
if minetest.get_modpath("intllib") then
    S = intllib.Getter()
else
    S = function(s,a,...)a={a,...}return s:gsub("@(%d+)",function(n)return a[tonumber(n)]end)end
end


advtrains.register_wagon("NY_lokomotive", {
	mesh="advtrains_engine_ny.b3d",
	textures = {"advtrains_engine_ny.png"},
	is_locomotive=true,
	drives_on={default=true},
	max_speed=10,
	seats = {
		{
			name=S("Driver Stand (left)"),
			attach_offset={x=-1, y=5, z=2},
			view_offset={x=0, y=-4, z=2},
			driving_ctrl_access=true,
			group = "dstand",
		},
{
			name="1",
			attach_offset={x=-4, y=8, z=0},
			view_offset={x=0, y=-4, z=0},
			group="pass",
		},
		{
			name="2",
			attach_offset={x=4, y=8, z=0},
			view_offset={x=0, y=-4, z=0},
			group="pass",
		},
		{
			name="3",
			attach_offset={x=-4, y=8, z=-8},
			view_offset={x=0, y=-4, z=0},
			group="pass",
		},
		{
			name="4",
			attach_offset={x=4, y=8, z=-8},
			view_offset={x=0, y=-4, z=0},
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
			name = "Passenger area",
			access_to = {"dstand"},
			require_doors_open=true,
		},
	},
	assign_to_seat_group = {"dstand", "pass"},
	doors={
		open={
			[-1]={frames={x=0, y=20}, time=1},
			[1]={frames={x=40, y=60}, time=1}
		},
		close={
			[-1]={frames={x=20, y=40}, time=1},
			[1]={frames={x=60, y=80}, time=1}
		}
	},
	visual_size = {x=1, y=1},
	wagon_span=4,
	collisionbox = {-1.0,-0.5,-1.0, 1.0,2.5,1.0},
	update_animation=function(self, velocity)
		if self.old_anim_velocity~=advtrains.abs_ceil(velocity) then
			self.object:set_animation({x=1,y=80}, advtrains.abs_ceil(velocity)*15, 0, true)
			self.old_anim_velocity=advtrains.abs_ceil(velocity)
		end
	end,


	drops={"advtrains:engine_ny"},
}, S("NY subway Engine"), "advtrains_engine_ny_inv.png")

minetest.register_craft({
	output = 'advtrains:NY_lokomotive',
	recipe = {
		{'default:steelblock', 'dye:black', 'default:steelblock'},
		{'group:aspen_wood', 'default:sign_wood', 'default:aspen_wood'},
		{'default:steelblock', 'dye:black', 'default:steelblock'},
	},
})

advtrains.register_wagon("ny_wagon", {
	mesh="advtrains_wagon_ny.b3d",
	textures = {"advtrains_engine_ny.png"},
	drives_on={default=true},
	max_speed=20,
	seats = {
		{
			name="1",
			attach_offset={x=-4, y=8, z=8},
			view_offset={x=0, y=-4, z=0},
			group="pass",
		},
		{
			name="2",
			attach_offset={x=4, y=8, z=8},
			view_offset={x=0, y=-4, z=0},
			group="pass",
		},
		{
			name="1a",
			attach_offset={x=-4, y=8, z=0},
			view_offset={x=0, y=-4, z=0},
			group="pass",
		},
		{
			name="2a",
			attach_offset={x=4, y=8, z=0},
			view_offset={x=0, y=-4, z=0},
			group="pass",
		},
		{
			name="3",
			attach_offset={x=-4, y=8, z=-8},
			view_offset={x=0, y=-4, z=0},
			group="pass",
		},
		{
			name="4",
			attach_offset={x=4, y=8, z=-8},
			view_offset={x=0, y=-4, z=0},
			group="pass",
		},
	},
	seat_groups = {
		pass={
			name = "Passenger area",
			access_to = {},
			require_doors_open=true,
		},
	},
	assign_to_seat_group = {"pass"},
	doors={
		open={
			[-1]={frames={x=0, y=20}, time=1},
			[1]={frames={x=40, y=60}, time=1}
		},
		close={
			[-1]={frames={x=20, y=40}, time=1},
			[1]={frames={x=60, y=80}, time=1}
		}
	},
	door_entry={-1, 1},
	visual_size = {x=1, y=1},
	wagon_span=2.3,
	collisionbox = {-1.0,-0.5,-1.0, 1.0,2.5,1.0},
	drops={"advtrains_wagon_ny"},
}, S("NY subway wagon"), "advtrains_wagon_ny_inv.png")

minetest.register_craft({
	output = 'advtrains:ny_wagon',
	recipe = {
		{'default:steelblock', 'dye:black', 'default:steelblock'},
		{'group:aspen_wood', 'dye:black', 'default:aspen_wood'},
		{'default:steelblock', 'dye:black', 'default:steelblock'},
	},
})

