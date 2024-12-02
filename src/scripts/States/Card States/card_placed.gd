extends State
class_name Card_Placed

var card

func Enter():
	if card.card_play_pay():
		if card.card_res.execute_check():
			card.card_res.card_execute()
			card.on_card_played()
	Transitioned.emit(self,"Card_Neutral")

func Update(delta:float):
	Transitioned.emit(self,"Card_Neutral")
	
