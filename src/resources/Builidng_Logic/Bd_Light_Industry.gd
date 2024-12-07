extends Building

# LIGHT INDUSTRY
# TODO

func get_updated_yield(tile_coords:Vector2i) -> Dictionary:
	var yields: Dictionary = base_yield.duplicate()
	var dict = EventController.get_map_control_node().get_adjacent_tiles(tile_coords)
	
	var production_bonus: int = 0
	var pollution_decrease: int = 0
	
	for e in dict:
		if dict.get(e).building:
			if (dict.get(e).building.building_tags.has("ENERGY_GENERATOR")):
				pollution_decrease = clampi(pollution_decrease+1,0,1)
			if (dict.get(e).building.building_tags.has("LIGHT_INDUSTRY")):
				production_bonus = clampi(production_bonus+1,0,1)

	yields.get_or_add("POLLUTION",0)
	yields["POLLUTION"] -= pollution_decrease
	yields.get_or_add("PRODUCTION",0)
	yields["PRODUCTION"] += production_bonus
	return yields
