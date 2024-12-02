extends Card

func execute_check() -> bool:
	var tile = EventController.get_map_control_node().get_pointing_tile()
	if tile:
		if (tile.building) or (tile.terrain == 1):
			return false
		else:
			return true
	return false

func card_execute() -> bool:
	EventController.get_map_control_node().add_building(assigned_building)
	return true
