extends Node2D

@onready var tilemap = $TileMapLayer
@onready var stilemap = $SelectionTML
@onready var camera = $Camera2D

const CONSIDER_AS_DRAG_TRESHOLD: float = 12
var mouse_click_pos: Vector2 = Vector2(0,0)
var mouse_release_pos: Vector2 = Vector2(0,0)
var leftclick_release_cd: int = 30

var mouse_hold: bool = false
var camera_dragging: bool = false


func _ready():
	pass # Replace with function body.


func _process(delta):
	
	leftclick_release_cd = clampi(leftclick_release_cd-1,0,10)
	
	# Cursor Selection
	stilemap.clear()
	var cursorpos: Vector2 = get_global_mouse_position()
	stilemap.set_cell(stilemap.local_to_map(cursorpos),1,Vector2i(1,0))
	
	if mouse_hold:
		#print(leftclick_hold_time)
		camera_dragging = true
	else:
		camera_dragging = false


func _input(event):
	
	# MOUSECLICK
	if Input.is_action_just_released("Left Click") and (leftclick_release_cd <= 0):
		mouse_release_pos = get_global_mouse_position()
		leftclick_release_cd = 10
		mouse_hold = false
		if (mouse_click_pos.distance_to(mouse_release_pos) < CONSIDER_AS_DRAG_TRESHOLD ):
			# INTEPRET AS CLICK
			add_test_building(get_global_mouse_position())

		camera_dragging = false
		
	elif Input.is_action_just_pressed("Left Click"):
		mouse_click_pos = get_global_mouse_position()
		mouse_hold = true
	
	# MOUSE MOTION
	if camera_dragging:
		if event is InputEventMouseMotion:
			camera.mouse_drag_camera(event.relative)

	# MOUSEWHEEL
	if Input.is_action_just_pressed("Mousewheel - Up"):
		camera.on_mousewheel(1)
	elif Input.is_action_just_pressed("Mousewheel - Down"):
		camera.on_mousewheel(-1)
	
func add_test_building(mouse_position:Vector2):
	print("map coords: ")
	print(tilemap.local_to_map(mouse_position))
	
	## test building add
	var wm = preload("res://src/scenes/wm_anim.tscn")
	var new_wm = wm.instantiate()
	new_wm.position = tilemap.map_to_local(tilemap.local_to_map(mouse_position))
	add_child(new_wm)
