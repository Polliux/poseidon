extends Node2D

@onready var tilemap = $TileMapLayer
@onready var stilemap = $SelectionTML
@onready var camera = $Camera2D

var zoom_level: int = 1
var zoom_cd: int = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	stilemap.clear()
	var cursorpos: Vector2 = get_global_mouse_position()
	stilemap.set_cell(stilemap.local_to_map(cursorpos),0,Vector2i(1,0))
	
	zoom_cd = clampi(zoom_cd-1,0,100)
	pass

func _input(event):
	if Input.is_action_just_pressed("Left Click"):
		print("map coords: ")
		print(tilemap.local_to_map(get_global_mouse_position()))
		
		## test building add
		var wm = preload("res://src/scenes/wm_anim.tscn")
		var new_wm = wm.instantiate()
		new_wm.position = tilemap.map_to_local(tilemap.local_to_map(get_global_mouse_position()))
		add_child(new_wm)
		
	if zoom_cd <= 0:
		if Input.is_action_just_pressed("Mousewheel - Up"):
			zoom_level = clampi(zoom_level+1,1,3)
			change_zoom()
			zoom_cd = 10
		elif Input.is_action_just_pressed("Mousewheel - Down"):
			zoom_level = clampi(zoom_level-1,1,3)
			change_zoom()
			zoom_cd = 10
	
func change_zoom() -> void:
	print(zoom_level)
	var zoom_value: float = 0.5 + (zoom_level * 0.5)
	camera.set_zoom(Vector2(zoom_value,zoom_value))
