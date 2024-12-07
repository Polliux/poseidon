extends Building

# TOWN
# TODO

func get_updated_yield(tile_coords:Vector2i) -> Dictionary:
	var yields: Dictionary = base_yield.duplicate()
	var dict = EventController.get_map_control_node().get_adjacent_tiles(tile_coords)
	var science_bonus:int = 0
	for e in dict:
		if dict.get(e).building:
			if (dict.get(e).building.building_tags.has("TOWN")):
				science_bonus = clampi(science_bonus+1,0,1)
	yields.get_or_add("SCIENCE",0)
	yields["SCIENCE"] += science_bonus
	return yields
