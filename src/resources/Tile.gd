class_name Tile
extends Object

var terrain: int
var yields: Dictionary
var building: Building
var path_to_sprite

# EARLY BUILDING CODE
# TODO REMOVE AND REFACTOR
func set_building(building_path):
	building = building_path
	update_yield()

func init()-> void:
	building = Building.new()

	for i in Yield.resource:
		yields[i] = 0

func update_yield() ->void:
	
	if building != null:
		for i in Yield.resource:
			yields[i] = building.base_yield[i]
