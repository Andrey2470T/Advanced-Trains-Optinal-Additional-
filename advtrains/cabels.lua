minetest.register_node("advtrains:capacitor", {
	description = "capacitor",
	tiles = {
		"advtrains_capacitor.png",
	},
	groups = {cracky = 2,},
	drawtype = "mesh",
    drawtype2 = "facedir",
	mesh = "advtrains_capacitor.b3d",
	paramtype = "light"
})
 
minetest.register_node("advtrains:cabel_n", {
	description = "cabel",
	tiles = {
		"advtrains_cabel.png",
	},
	groups = {cracky = 2,},
	drawtype = "mesh",
	mesh = "advtrains_cabel_n.b3d",
	paramtype = "light"
})
 
minetest.register_node("advtrains:mast", {
	description = "mast",
	tiles = {
		"advtrains_mast.png",
	},
	groups = {cracky = 2,},
	drawtype = "mesh",
	mesh = "advtrains_mast.b3d",
	paramtype = "light",
})


