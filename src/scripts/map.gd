extends Node2D

@onready var tilemap = $Terrain/TileMapLayer
@onready var stilemap = $Terrain/SelectionTML
@onready var camera = $Camera2D
@onready var buildings_node = $Buildings

@onready var top_ui_node = get_node("/root/Game Control/Top UI Control")

const MAP_H_MAX: int = 40
const MAP_Q_MAX:int = 30
const GROUND_TILE_ODDS: float = 0.57

var tilelist: Dictionary = create_master_tilelist()

const CONSIDER_AS_DRAG_TRESHOLD: float = 12
var mouse_click_pos: Vector2 = Vector2(0,0)
var mouse_release_pos: Vector2 = Vector2(0,0)
var leftclick_release_cd: int = 30

var mouse_hold: bool = false
var camera_dragging: bool = false


func _ready():
	
	EventController.assign_as_map_control(self)
	#db_build_all_tiles()
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
			#var random_terrain: Vector2 = Vector2(randi_range(0,2),randi_range(0,1))
			if randf() >= GROUND_TILE_ODDS:
				new_tile.terrain = 1
			else:
				new_tile.terrain = 0
			
			new_tilelist[Vector2i(h,q)] = new_tile
			new_tile.init()
			
	return new_tilelist

func _input(event):
	
	# MOUSECLICK
	if Input.is_action_just_released("Left Click") and (leftclick_release_cd <= 0):
		mouse_release_pos = get_global_mouse_position()
		leftclick_release_cd = 10
		mouse_hold = false
		if (mouse_click_pos.distance_to(mouse_release_pos) < CONSIDER_AS_DRAG_TRESHOLD ):
			# INTEPRET AS CLICK
			#add_test_building(get_global_mouse_position())
			pass

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
	if tilelist.has(Vector2i(tilemap.local_to_map(mouse_position))):
		if tilelist[Vector2i(tilemap.local_to_map(mouse_position))].terrain == 0:
			#assign_building_to_tile(tilemap.local_to_map(mouse_position))
			pass
			
func add_building(bd: Building):
	var mouse_position:Vector2 = get_local_mouse_position()
	if tilelist.has(Vector2i(tilemap.local_to_map(mouse_position))):
		if tilelist[Vector2i(tilemap.local_to_map(mouse_position))].terrain == 0:
			assign_building_to_tile(tilemap.local_to_map(mouse_position),bd)
		
func assign_building_to_tile(coords:Vector2i, bd: Building) -> void:
	tilelist[coords].set_building(bd,coords)
	var dict = get_adjacent_tiles(coords)
	# UPDATE ADJACENCIES FOR ADJACENT BUILDING
	for i in dict:
		dict.get(i).update_yield(i)
	
	update_building_sprite_at(coords)
	update_total_yields()
		
func update_building_sprite_at(coords: Vector2i):
	var tile = tilelist.get(coords)
	if tile.building != null:
		if tile.path_to_sprite != null:
			tile.path_to_sprite.queue_free()
			
		var sprite = tile.building.tile_sprite_ps.instantiate()
		sprite.speed_scale = randf_range(0.6,1.4)
		#sprite.scale = Vector2(1.5,1.5)
			
		sprite.position = tilemap.map_to_local(coords)
		buildings_node.add_child(sprite)
		tile.path_to_sprite = sprite

# DEBUG BUILD AT ALL GROUND TILES
func db_build_all_tiles()-> void:
	for i in MAP_H_MAX:
		for e in MAP_Q_MAX:
			# IF GROUND, RANDOM BUILD
			if (tilelist[Vector2i(i,e)].terrain == 0):
				pass

# GET TILE OBJECT OF CURRENT MOUSE CURSOR POSITION
func get_pointing_tile():
	var mouse = get_global_mouse_position()
	if tilelist[tilemap.local_to_map(mouse)]:
		return tilelist[tilemap.local_to_map(mouse)]
	else:
		return null

# TODO: REFACTOR FOR EFFICIENCY
func get_tile(coords:Vector2i):
	return tilelist[coords]

func update_total_yields():
	var total_yields:Dictionary = {}
	for n in Yield.resource:
		total_yields[n] = 0;
	for i in tilelist:
		for r in Yield.resource:
			total_yields[r] += tilelist[i].yields[r]
			
	for n in Yield.resource:
		top_ui_node.modify_delta_value(str(n),total_yields[n],0)
		
func get_adjacent_tiles(coords:Vector2i) -> Dictionary:
	var dict:Dictionary = {}
	var arr = tilemap.get_surrounding_cells(Vector2i(coords))
	for i in arr:
		if tilelist.has(i):
			dict[i] = tilelist[i]
	return dict
	
	
