extends State
class_name Card_Placed

var card

func Enter():
	print("Placed")
	if card.card_res.execute_check():
		print("Execute")
		card.card_res.card_execute()
		card.on_card_played()
	else:
		Transitioned.emit(self,"Card_Neutral")
	pass

func Update(delta:float):
	Transitioned.emit(self,"Card_Neutral")
