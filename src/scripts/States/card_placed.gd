extends State
class_name Card_Placed

var card

func Enter():
	print("Placed")
	card.card_res.card_execute()
	card.on_card_played()
	pass

func Update(delta:float):
	Transitioned.emit(self,"Card_Neutral")
