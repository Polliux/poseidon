extends Control

@export var hand_node: Node
@export var card_frame: PackedScene
@export var reshuffle_from: Node
@export_enum ("TOP", "BOTTOM") var ui_position_v
@export_enum ("LEFT", "RIGHT") var ui_position_h

var card_piles: Array[Card] = []

func _ready():
	on_pile_changes()
	pass 


func _process(delta):
	pass

func random_draw():
	if card_piles.size() <= 0:
		if reshuffle_from:
			if reshuffle():
				pass
			else:
				print("0 DISCARD PILE SHUFFLED - ERROR")
				return null
		else:
			print("RESHUFFLING FROM UNASSIGNED")
	if card_piles.size() >= 1 :
		var card = card_piles.pop_at(randi_range(0,(card_piles.size()-1)))
		on_pile_changes()
		return card
	else:
		return null

func reshuffle() -> bool:
	if reshuffle_from.card_piles.size() >= 1:
		card_piles = reshuffle_from.card_piles.duplicate()
		on_pile_changes()
		if reshuffle_from.has_method("clear_pile"):
			reshuffle_from.clear_pile()
		return true
	else:
		return false
	
	
func clear_pile():
	card_piles.clear()
	on_pile_changes()

func insert(card:Card) -> bool:
	if card:
		card_piles.append(card)
		on_pile_changes()
		return true
	else:
		return false

func into_player_hand() -> bool:
	var card = random_draw()
	if card:
		var new_card = card_frame.instantiate()
		new_card.card_res = card
		new_card.player_interatable = true
		new_card.discard_pile = reshuffle_from
		add_child(new_card)
		new_card.reparent(hand_node)
		return true
	else:
		return false
		
func size_change_UI(new_size:Vector2) -> void:
	
	var new_position:Vector2 = Vector2.ZERO
	
	if ui_position_v == 0:
		new_position.y = new_size.y * 0.10
	elif ui_position_v == 1:
		new_position.y =( new_size.y * 0.90)  - (self.size.y/2)
	if ui_position_h == 0:
		new_position.x = new_size.x * 0.10 - (self.size.x*2)
	elif ui_position_h == 1:
		new_position.x = new_size.x * 0.90 + (self.size.x)
		
	position = new_position

func on_pile_changes():
	var dict: Dictionary = {}
	for i in card_piles:
		dict.get_or_add(i.card_title,0)
		dict[i.card_title] += 1
	set_tooltip_text(str(dict))
