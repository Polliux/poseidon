extends State
class_name Middle_Phase

func Enter():
	print("Entered Middle Phase")
	EventController.get_ui_control().increment_all_by_delta()
	await get_tree().create_timer(0.50).timeout
	Transitioned.emit(self,"Draw_Phase")
	
func Exit():
	pass
	
func Update(delta):
	pass
	
func UpdateInputEvent(event):
	pass
