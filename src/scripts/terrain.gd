extends Node2D

@onready var terrain_tilemap = $TileMapLayer

const MAP_H_MAX: int = 50
const MAP_Q_MAX: int = 30

func _ready():
	terrain_tilemap.clear()
	random_terrain_gen()
	
func _process(delta):
	pass

func random_terrain_gen():
	#DEBUG
	var tl = owner.tilelist
	for i in tl:
		var random_terrain: Vector2 = Vector2(randi_range(0,2),tl[i].terrain)
		terrain_tilemap.set_cell(i,0,random_terrain)
