class_name Tile
extends Object

var terrain: int
var yields: Dictionary
var building: Building

# EARLY BUILDING CODE
# TODO REMOVE AND REFACTOR
func set_building(path):
	building = load(path)

func init()-> void:
	building = Building.new()
	building.init()
