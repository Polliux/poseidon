extends Building

# TOWN
# TODO

func get_updated_yield(tile_coords:Vector2i) -> Dictionary:
	var yields: Dictionary = {}
	var dict = EventController.get_map_control_node().get_adjacent_tiles(tile_coords)
	var adj:int = 0
	for e in dict:
		if dict.get(e).building:
			if (dict.get(e).building.building_tags.has("TOWN")):
				adj += 1
	adj = floori(adj/2)
	yields["PRODUCTION"] = adj + 1
	return yields
