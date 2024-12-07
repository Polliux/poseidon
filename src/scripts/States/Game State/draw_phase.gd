extends State
class_name Draw_Phase

@export var scene_node: Node

func Enter():
	print("Entered Draw Phase")
	get_parent().trigger_draws()
	await get_tree().create_timer(0.50).timeout
	Transitioned.emit(self,"Neutral")
	
func Exit():
	get_parent().update_piles()
	var pollution = EventController.get_ui_control().get_resource_value("POLLUTION")
	if pollution:
		if (pollution >= GlobalDefines.MAX_POLLUTION_STATE):
			if scene_node:
				scene_node.game_over()
		elif (pollution >= GlobalDefines.SEVERE_POLLUTION_STATE):
			get_parent().trigger_issue_insert(3)
		elif (pollution >= GlobalDefines.MODERATE_POLLUTION_STATE):
			get_parent().trigger_issue_insert(2)
		elif (pollution >= GlobalDefines.MINOR_POLLUTION_STATE):
			get_parent().trigger_issue_insert(1)
	
func Update(delta):
	pass
	
func UpdateInputEvent(event):
	pass
