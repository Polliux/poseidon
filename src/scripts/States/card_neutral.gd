extends State
class_name Card_Neutral

var card

func Enter():
	card.reset_alpha()
	card.scale = Vector2(1,1)
	print("Neutral")
	pass

func To_Clicked():
	Transitioned.emit(self,"Card_Clicked")
