extends State
class_name Card_Placed

var card

func Enter():
	if card.card_play_pay():
		if card.card_res.execute_check():
			card.card_pay()
			card.card_res.card_execute()
			card.on_card_played()
	else:
		var popout = load("res://src/scenes/msg_box.tscn").instantiate()
		popout.set_message("Insufficient Resources")
		print("bd")
		EventController.game_control_node.add_child(popout)
	Transitioned.emit(self,"Card_Neutral")

func Update(delta:float):
	Transitioned.emit(self,"Card_Neutral")
	
