extends Node

# AUTOLOAD

var game_control_node
var map_control_node
var ui_control_node
var sfx_control_node

var resource_score: int = 0
var latest_resource_value: Dictionary = {}
var current_turn: int = 0

func assign_as_sfx_control(node:Node):
	sfx_control_node = node

func assign_as_game_control(node:Node):
	game_control_node = node
	
func assign_as_map_control(node:Node):
	map_control_node = node

func assign_as_ui_control(node:Node):
	ui_control_node = node

func get_sfx_control() -> Node:
	return sfx_control_node
	
func get_game_control_node() -> Node:
	return game_control_node

func get_map_control_node() -> Node:
	return map_control_node

func get_ui_control() -> Node:
	return ui_control_node
