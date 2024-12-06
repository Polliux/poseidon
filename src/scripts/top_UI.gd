extends Node2D

@onready var bgnode = $Background
enum {DECREMENT = -1, SET, INCREMENT}

var resource_score: int = 0
var turn: int = 0

func _ready():
	EventController.assign_as_ui_control(self)
	set_start_resource()
	size_change_UI(get_viewport_rect().size)

func _process(delta):
	pass

func size_change_UI(new_size:Vector2) -> void:
	# ON WINDOW SIZE CHANGE - MATCH UI HORIZONTAL SIZE
	bgnode.size.x = new_size.x

func set_start_resource() -> void:
	# SET STARTING RESOURCE
	for i in GlobalDefines.STARTING_RESOURCES:
		modify_resource_value(i,GlobalDefines.STARTING_RESOURCES.get(i), SET)
	
	for i in GlobalDefines.STARTING_DELTA:
		modify_delta_value(i,GlobalDefines.STARTING_DELTA.get(i), SET)


func modify_resource_value(resource: String, value: int, mode: int) -> void:
	# SET, INCR OR DECRE SPECIFIC RESOURCE BY VALUE
			var rv = get_resource_node(resource).get_node("VBoxContainer/Res Panel/Resource Value")
			var new_value: int = 0
			match mode:
				0:
					new_value = value
				1:
					new_value = int(rv.text) + value
				-1:
					new_value = int(rv.text) - value
			rv.set_text(str(new_value))
			
			if resource != "POLLUTION" and mode == 1:
				resource_score += value
			
func modify_delta_value(resource: String, value: int, mode: int) -> void:
	# SET, INCR OR DECRE SPECIFIC RESOURCE BY VALUE
			var rv = get_resource_node(resource).get_node("VBoxContainer/Mod Panel/Mod Value")
			var new_value: int = 0

			var new_str: String = ""
			match mode:
				0:
					new_value = value
				1:
					new_value = int(rv.text) + value
				-1:
					new_value = int(rv.text) - value
					
			if resource == "POLLUTION":
				new_str += "+"
				rv.set("theme_override_colors/font_color",Color.SEA_GREEN)
			else:
				if new_value >= 0:
					new_str += "+"
					rv.set("theme_override_colors/font_color",Color.LIME_GREEN)
				else:
					
					rv.set("theme_override_colors/font_color",Color.RED)
			rv.set_text(new_str + str(new_value))

func get_resource_value(resource: String) -> int:
	# RETURN SPECIFIED RESOURCE VALUE
	return int(get_resource_node(resource).get_node_or_null("VBoxContainer/Res Panel/Resource Value").text)

func get_delta_value(resource: String) -> int:
	# RETURN SPECIFIED RESOURCE VALUE
	return int(get_resource_node(resource).get_node_or_null("VBoxContainer/Mod Panel/Mod Value").text)
	
func get_resource_node(resource: String) -> Node:
	# RETURN RESOURCE CELL NODE FOR SPECIFIED RESOURCE NAME
	var path_to_resource = $"Background/Background_Interior/Top Layer/Top Vertical/Resource"
	
	for i in path_to_resource.get_child_count():
		var rescell = path_to_resource.get_child(i)
		var lb = rescell.get_node_or_null("Resource Label")
		
		if lb != null and lb.text == resource:
			return rescell
	
	return null

func increment_all_by_delta() -> void:
	for i in Yield.resource:
		modify_resource_value(i,get_delta_value(i), INCREMENT)

func end_of_turn_triggered():
	increment_all_by_delta()
	update_global_score()
	turn += 1
	
func get_resource_dict() -> Dictionary:
	var dict: Dictionary = {}
	for i in Yield.resource:
		dict[i] = get_resource_value(i)
	return dict

func update_global_score():
	EventController.current_turn = self.turn
	EventController.resource_score = self.resource_score
	EventController.latest_resource_value = get_resource_dict()
	print(EventController.latest_resource_value)
