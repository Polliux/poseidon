extends Node2D

@onready var map_vp = $"SubViewportContainer/Map Subviewport"

signal card_action

var map_node

func _ready():
	
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
	
	# INIT TEST HAND/CARDS
	var hand_node = preload("res://src/scenes/hand.tscn").instantiate()
	add_child(hand_node)
	for i in range(1):
		hand_node.draw_card()
	
	window_resized()
	
	# GET & ASSIGN MAP NODE
	map_node = map_vp.get_node("Game Map Node")
	
func get_map_node():
	if map_node:
		return map_node

func _process(delta):
	pass

func window_resized() -> void:
	
	var new_size = get_viewport_rect().size
	var current_top_ui = get_node_or_null("Top UI Control")
	var current_hand_node = get_node_or_null("Hand")
	
	map_vp.size = new_size
	if current_top_ui != null:
		current_top_ui.size_change_UI(new_size)
	if current_hand_node != null:
		current_hand_node.update_hand_position(new_size)
	

func _on_debug_add_card_pressed() -> void:
	var hand = get_node("Hand")
	hand.draw_card()

func _on_debug_regenerate_pressed() -> void:
	#map_node = map_vp.get_node("Game Map Node")
	map_node.db_build_all_tiles()
	
	
