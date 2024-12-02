extends State
class_name Neutral_Phase

func Enter():
	pass
	
func Exit():
	pass
	
func Update(delta):
	pass
	
func UpdateInputEvent(event):
	pass

func _on_end_turn_pressed():
	Transitioned.emit(self,"Discard_Phase")
