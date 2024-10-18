extends Node2D

var card_frame = preload("res://src/scenes/card.tscn")

@export var card_height_curve: Curve
@export var card_spread_curve: Curve

var sort_hand: bool = true
const PER_CARD_HORIZONTAL: int = 20
const CARD_HORIZONTAL_MIN_MARGIN: int = 5
const CARD_VERTICAL_OFFSET = 60
const CARD_SIZE_Y: int = 200/2
const CARD_TILT_RADIAN_MULT: float = 0.25

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
	

func draw_card() -> void:
	add_child(card_frame.instantiate())
	update_hand_card_pos()
	
func update_hand_card_pos() -> void:
	
	var hand = get_child_count()
	
	for index in hand:
		var card = get_child(index)
		var ratio: float = 0.5
		if hand > 1:
			ratio = float(index)/float(hand-1)

		var target_position: Vector2 = Vector2(0,0)
		var target_tilt: float = 0
		
		# CARD POSITION
		target_position.x = ((ratio-0.5) * CARD_HORIZONTAL_MIN_MARGIN) * (hand * PER_CARD_HORIZONTAL)
		target_position.y = -card_height_curve.sample(ratio) * CARD_VERTICAL_OFFSET
		card.target_pos = target_position
		
		# CARD TILT
		target_tilt = card_spread_curve.sample(ratio) * CARD_TILT_RADIAN_MULT
		card.target_tilt = target_tilt


func update_hand_position(window_size: Vector2) -> void:
	var new_x = floor(window_size.x/2)
	var new_y = floor(window_size.y*(0.97) - CARD_SIZE_Y)
	self.position = Vector2(new_x,new_y)
	update_hand_card_pos()
