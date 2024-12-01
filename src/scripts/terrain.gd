extends Node2D

@onready var terrain_tilemap = $TileMapLayer

var map_H_MAX: int
var map_Q_MAX: int

const TERRAIN_VARIANCE_X: int = 6-1

func _ready():
	
	map_H_MAX = get_parent().MAP_H_MAX
	map_Q_MAX = get_parent().MAP_Q_MAX
	terrain_tilemap.clear()
	random_terrain_gen()
	
func _process(delta):
	pass

func random_terrain_gen():
	#DEBUG
	var tl = owner.tilelist
	for i in tl:
		var random_terrain: Vector2 = Vector2(randi_range(0,TERRAIN_VARIANCE_X),tl[i].terrain)
		terrain_tilemap.set_cell(i,0,random_terrain)
