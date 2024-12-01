extends State
class_name Card_Clicked

var card

func Enter():
	pass

func Update(delta:float):
	pass

func UpdateInputEvent(event):
	if event is InputEventMouseMotion:
		Transitioned.emit(self,"Card_Dragging")
	else:
		Transitioned.emit(self,"Card_Neutral")
