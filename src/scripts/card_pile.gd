extends Control

@export var hand_node: Node
@export var card_frame: PackedScene
@export var reshuffle_from: Node
@export var area2d_node: Area2D

var pile_menu

@export_enum ("TOP", "BOTTOM") var ui_position_v
@export_enum ("LEFT", "RIGHT") var ui_position_h

var card_piles: Array[Card] = []

func _ready():
	on_pile_changes()
	pass 

func _process(delta):
	pass
	
func _on_area_2d_input_event(viewport, event, shape_idx):
	print(event)
	if event.is_action_pressed("Left Click"):
		var panel = preload("res://src/scenes/collection_room.tscn").instantiate()
		panel.mode = 1
		pile_menu = panel
		
		panel.load_cards(content_to_dict())
		get_parent().add_child(panel)

		
func content_to_dict() -> Dictionary:
	var dict: Dictionary
	var counter:int = 0
	for i in card_piles:
			dict[counter] = card_piles[counter]
			counter += 1
	return dict
		
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
		if new_card.card_res.has_method("on_draw_effect"):
			new_card.card_res.on_draw_effect()
		
		EventController.get_sfx_control().play_sfx_clack()
		
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
	
func update_pile_menu():
	if pile_menu:
		if pile_menu != null:
			pile_menu.load_cards(content_to_dict())
	
