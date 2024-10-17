class_name Tile
extends Object

var terrain: int
var yields: Dictionary
var building: Building

func set_building(path):
	building = load(path)
