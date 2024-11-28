extends State
class_name Card_Clicked

var card

func Enter():
	print("Clicked")
	pass

func Update(delta:float):
	pass

func UpdateInputEvent(event):
	if event is InputEventMouseMotion:
		if event.relative > Vector2(4,4):
			Transitioned.emit(self,"Card_Dragging")
