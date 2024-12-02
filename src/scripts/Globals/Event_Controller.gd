extends Node

# AUTOLOAD

var game_control_node
var map_control_node

func assign_as_game_control(node:Node):
	game_control_node = node
	
func assign_as_map_control(node:Node):
	map_control_node = node

func get_game_control_node() -> Node:
	return game_control_node

func get_map_control_node() -> Node:
	return map_control_node
