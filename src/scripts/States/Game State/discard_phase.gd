extends State
class_name Discard_Phase

@export var player_hand: Node

func Enter():
	print("Entered Discard Phase")
	player_hand.discard_all()
	await get_tree().create_timer(0.50).timeout
	Transitioned.emit(self,"Mid_Phase")
	
func Exit():
	pass
	
func Update(delta):
	pass
	
func UpdateInputEvent(event):
	pass
