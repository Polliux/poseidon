class_name Building
extends Resource

@export var id:String
@export var building_name:String

@export var number:int = 0

@export var tile_sprite_ps: PackedScene

@export var base_yield: Dictionary = Yield.zero_yields()

func get_base_yield():
	return base_yield
	
func set_base_yield(new_yield: Dictionary):
	base_yield = new_yield


func get_updated_yield(tile_coords:Vector2i) -> Dictionary:
	return base_yield
