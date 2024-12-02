extends State
class_name Card_Neutral

var card

func Enter():
	pass


func To_Clicked():
	Transitioned.emit(self,"Card_Clicked")
