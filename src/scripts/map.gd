extends Node2D

@onready var tilemap = $Terrain/TileMapLayer
@onready var stilemap = $Terrain/SelectionTML
@onready var camera = $Camera2D
@onready var buildings_node = $Buildings

@export var test_building: Building

const MAP_H_MAX: int = 40
const MAP_Q_MAX:int = 30

var tilelist: Dictionary = create_master_tilelist()

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
		
func create_master_tilelist():
	var new_tilelist: Dictionary = {}
	
	for h in range(MAP_H_MAX):
		for q in range(MAP_Q_MAX):
			var new_tile = Tile.new()
			var random_terrain: Vector2 = Vector2(randi_range(0,2),randi_range(0,1))
			new_tile.terrain = randi_range(0,1)
			
			new_tilelist[Vector2(h,q)] = new_tile
			
	return new_tilelist

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
	
func add_test_building(mouse_position:Vector2) -> void:
	
	if test_building != null:
		
		print("map coords: ")
		var coords: Vector2 = tilemap.local_to_map(mouse_position)
		print(coords)
		print(test_building.id)
		
		# INVALID PLACEMENT FEEDBACK
		if tilelist.get(coords).terrain != 0:
			# TODO: invalid sfx + flash selection tmp layer
			return
		
		## add test building
		tilelist.get(coords).set_building("res://src/resources/Buildings/Generic Factory.tres")
		update_building_sprite_at(coords)
	
func update_building_sprite_at(coords: Vector2):
	if tilelist.get(coords).building != null:
		var new_building = tilelist.get(coords).building.anim_tile_sprite_path.instantiate()
		new_building.position = tilemap.map_to_local(coords)
		buildings_node.add_child(new_building)
