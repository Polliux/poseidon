extends State
class_name Card_Dragging

var card

func Enter():
	print("Dragging")
	pass

func UpdateInputEvent(event):
	if event is InputEventMouseMotion:
		card.position += event.relative
		
	if Input.is_action_just_released("Left Click"):
		
		# PLACED OR DEFAULT TO NEUTRAL
		Transitioned.emit(self,"Card_Neutral")
