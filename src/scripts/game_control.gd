extends Node2D

@export var map_vp: SubViewport
@export var science_shop: Node
@export var drawpile_node: Node
@export var discardpile_node: Node
@export var end_turn_button: Button

var science_gui_toggle: bool = false
var full_viewport: Vector2 = Vector2.ZERO

signal card_action

var map_node

func _ready():
	
	Cards_Collection.load()
	
	# CONNECT TO MASTER NODE
	EventController.assign_as_game_control(self)
	
	# WINDOW SIZE CHANGE SIGNAL
	get_tree().get_root().size_changed.connect(window_resized)
	
	# INIT TOP UI
	var top_ui = preload("res://src/scenes/top_UI.tscn")
	add_child(top_ui.instantiate())
	
	# INIT MAP
	map_vp.size = get_viewport_rect().size
	
	var main_map = preload("res://src/scenes/map.tscn")
	var new_main_map = main_map.instantiate()
	map_vp.add_child(new_main_map)
	
	
	window_resized()
	
	# GET & ASSIGN MAP NODE
	map_node = map_vp.get_node("Game Map Node")
	
func get_map_node():
	if map_node:
		return map_node

func _process(delta):
	test_modulate()
	pass
	
func test_modulate():
	pass

func window_resized() -> void:
	
	full_viewport = get_viewport_rect().size
	var current_top_ui = get_node_or_null("Top UI Control")
	var current_hand_node = get_node_or_null("Hand")
	
	map_vp.size = full_viewport
	if current_top_ui:
		current_top_ui.size_change_UI(full_viewport)
	if current_hand_node:
		current_hand_node.update_hand_position(full_viewport)
	if drawpile_node:
		drawpile_node.size_change_UI(full_viewport)
	if discardpile_node:
		discardpile_node.size_change_UI(full_viewport)
	if science_shop:
		science_shop.size_change_UI(full_viewport, science_gui_toggle)
	if end_turn_button:
		end_turn_button.position.y = (full_viewport.y * 0.90)
		end_turn_button.position.x = (full_viewport.x * 0.80) + (end_turn_button.size.x/2)
		

func add_to_discard_pile(card:Card) -> void:
	discardpile_node.insert(card)
	

func _on_debug_regenerate_pressed() -> void:
	#map_node = map_vp.get_node("Game Map Node")
	map_node.db_build_all_tiles()
	
func _on_debug_draw_cards_pressed() -> void:
	if drawpile_node:
		drawpile_node.into_player_hand()
	
func _on_debug_cards_to_drawpile_pressed() -> void:
	
	var card:Card
	for i in range(10):
		card = Cards_Collection.get_random_card_res()
		drawpile_node.insert(card)

func _on_toggle_science_shop_pressed():
	if science_gui_toggle:
		science_gui_toggle = false
	else:
		science_gui_toggle = true
	science_shop.size_change_UI(full_viewport, science_gui_toggle)
