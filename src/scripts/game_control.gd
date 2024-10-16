extends Node2D

@onready var map_vp = $"SubViewportContainer/Map Subviewport"


func _ready():
	
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
	

func _process(delta):
	pass

func window_resized() -> void:
	
	var new_size = get_viewport_rect().size
	var current_top_ui = get_node_or_null("Top UI Control")
	
	map_vp.size = new_size
	if current_top_ui != null:
		current_top_ui.size_change_UI(new_size)
	
	
