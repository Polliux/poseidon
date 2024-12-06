extends Building

# WINDMILL
# +1 ENERGY PER 2 EMPTY NEIGHBOUR TILE

func get_updated_yield(tile_coords:Vector2i) -> Dictionary:
	var yields: Dictionary = {}
	var dict = EventController.get_map_control_node().get_adjacent_tiles(tile_coords)
	var energy:int = 0
	for e in dict:
		if not (dict.get(e).building):
			energy += 1
	energy = floori(energy/2)
	yields["ENERGY"] = energy
	return yields
