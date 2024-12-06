extends State
class_name Draw_Phase

@export var scene_node: Node

func Enter():
	print("Entered Draw Phase")
	get_parent().trigger_draws()
	await get_tree().create_timer(0.50).timeout
	Transitioned.emit(self,"Neutral")
	
func Exit():
	if EventController.get_ui_control().get_resource_value("POLLUTION"):
		if (EventController.get_ui_control().get_resource_value("POLLUTION") >= GlobalDefines.MAX_POLLUTION_STATE):
			if scene_node:
				scene_node.game_over()
	
func Update(delta):
	pass
	
func UpdateInputEvent(event):
	pass
