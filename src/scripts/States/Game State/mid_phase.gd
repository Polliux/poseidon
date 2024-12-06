extends State
class_name Middle_Phase

func Enter():
	print("Entered Middle Phase")
	get_parent().trigger_shop_refresh()
	EventController.get_ui_control().end_of_turn_triggered()
	await get_tree().create_timer(0.50).timeout
	Transitioned.emit(self,"Draw_Phase")
	
func Exit():
	pass
	
func Update(delta):
	pass
	
func UpdateInputEvent(event):
	pass
