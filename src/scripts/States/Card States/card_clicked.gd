extends State
class_name Card_Clicked

var card

func Enter():
	if card.mode == 1:
		# SCIENCE BUY
		if not card.on_buy_attempt():
			Transitioned.emit(self,"Card_Neutral")

func Update(delta:float):
	pass

func UpdateInputEvent(event):
	if card.mode == 0:
		if event is InputEventMouseMotion:
			Transitioned.emit(self,"Card_Dragging")
		else:
			Transitioned.emit(self,"Card_Neutral")
