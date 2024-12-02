extends State
class_name Draw_Phase

func Enter():
	print("Entered Draw Phase")
	get_parent().trigger_draws()
	await get_tree().create_timer(0.50).timeout
	Transitioned.emit(self,"Neutral")
	
func Exit():
	pass
	
func Update(delta):
	pass
	
func UpdateInputEvent(event):
	pass
