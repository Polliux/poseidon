class_name Card
extends Resource

@export var card_title:String = ""
@export var card_image:Texture2D
@export var cost_to_play:Dictionary = Yield.zero_yields()
@export var science_buy_cost: int = 10
@export var appear_in_shop: bool = true

@export_enum ("REGULAR", "ISSUE") var card_type
@export var exhaust: bool = false
@export var assigned_building: Building
# HAS TO BE OR INHERITS FROM BUILDING TYPE
# WEIRD GODOT QUIRK -
# DOES NOT RECOGNIZE RESOURCE USING SCRIPTS INHERITED FROM THE SAME CLASS
# WORKAROUND : DRAG DROP RES PATH FROM INSPECTOR

@export_multiline var card_info: String = ""

var current_science_buy_cost: int = science_buy_cost

func get_title() -> String:
	return card_title

func get_image() -> Texture2D:
	return card_image
	
func logic_get_map_node():
	return EventController.game_control_node.get_map_node()

func logic_get_tile_cell(mouse_pos:Vector2):
	return EventController.game_control_node.get_map_node().get_mouse_hex(mouse_pos)
	
func logic_get_neighbours(mouse_pos:Vector2):
	return EventController.game_control_node.get_map_node().get_mouse_hex_neighbours(mouse_pos)

# VIRTUAL
func card_execute() -> bool:
	EventController.get_map_control_node().add_building(assigned_building)
	return true

func execute_check() -> bool:
	return false

func on_draw_effect():
	pass
