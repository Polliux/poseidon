class_name Tile
extends Object

var terrain: int
var yields: Dictionary
var building: Building
var path_to_sprite

# EARLY BUILDING CODE
# TODO REMOVE AND REFACTOR
func set_building(new_building,tile_coords:Vector2i):
	building = new_building
	update_yield(tile_coords)

func init()-> void:
	
	for i in Yield.resource:
		yields[i] = 0

func update_yield(tile_coords:Vector2i) ->void:
	var bd_yields: Dictionary = {}
	var fn_yields: Dictionary = {}
	if building:
			bd_yields = building.get_updated_yield(tile_coords)
	for i in Yield.resource:
		if bd_yields.has(i):
			fn_yields[i] = bd_yields[i]
		else:
			fn_yields[i] = 0
	yields = fn_yields
