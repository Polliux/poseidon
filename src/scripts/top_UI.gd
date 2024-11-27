extends Node2D

@onready var bgnode = $Background
enum {DECREMENT = -1, SET, INCREMENT}

func _ready():
	set_start_resource()
	size_change_UI(get_viewport_rect().size)

func _process(delta):
	pass

func size_change_UI(new_size:Vector2) -> void:
	# ON WINDOW SIZE CHANGE - MATCH UI HORIZONTAL SIZE
	bgnode.size.x = new_size.x

func set_start_resource() -> void:
	# SET STARTING RESOURCE
	modify_resource_value("Energy",20, SET)
	modify_resource_value("Science",45, SET)
	modify_resource_value("Production",32, SET)
	
	modify_delta_value("Energy",3, SET)
	modify_delta_value("Science",1, SET)
	modify_delta_value("Production",1, SET)

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
			if new_value >= 0:
				new_str += "+"
				rv.set("theme_override_colors/font_color",Color.LIME_GREEN)
			else:
				new_str += "-"
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
