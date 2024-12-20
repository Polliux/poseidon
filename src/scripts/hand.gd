extends Node2D

var sort_hand: bool = true

const CARD_SIZE_Y: int = 220/2

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

	
func update_hand_card_pos() -> void:
	for index in get_child_count():
		var card = get_child(index)
		card.update_on_hand_pos()

func update_hand_position(window_size: Vector2) -> void:
	var new_x = floor(window_size.x/2)
	var new_y = floor(window_size.y*(1.00) - CARD_SIZE_Y)
	self.position = Vector2(new_x,new_y)
	update_hand_card_pos()
	
func _on_child_order_changed():
	update_hand_card_pos()

func discard_all():
	var max = get_child_count()
	for i in range(max):
		var n = max - i - 1
		get_child(n).player_interatable = false
		get_child(n).discard()
		await get_tree().create_timer(0.03).timeout

func toggle_interactable(flag:bool):
	var max = get_child_count()
	for i in range(max):
		var n = max - i - 1
		get_child(n).player_interatable = flag
