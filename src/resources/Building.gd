class_name Building
extends Resource

enum resource {
	ENERGY,
	SCIENCE,
	PRODUCTION
}

@export var id:String
#@export var nid: int

@export var number:int = 0

@export var tile_sprite_path: PackedScene
@export var anim_tile_sprite_path: PackedScene = preload("res://src/scenes/Animated/wm_anim.tscn")
@export var anim_tile_sprite_path2: PackedScene = preload("res://src/scenes/Animated/genfac_anim.tscn")

@export var base_yield: Dictionary

func init():
	for i in resource:
		base_yield[i] = 0
