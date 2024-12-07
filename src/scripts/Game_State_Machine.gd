extends Node

@export var initial_state : State
@export var draw_pile: Node
@export var discard_pile: Node
@export var science_node: Node

signal state_changed

var current_state: State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.Update(delta)

func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)
		
func _input(event):
	if current_state:
		current_state.UpdateInputEvent(event)

func on_child_transition(state,new_state_name):
	state_changed.emit(state,new_state_name)
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if !new_state_name:
		return
		
	if current_state:
		current_state.Exit()
	new_state.Enter()
	current_state = new_state
	pass
	
func trigger_draws():
	for i in range(GlobalDefines.CARD_DRAW_PER_TURN):
		if draw_pile.into_player_hand():
			await get_tree().create_timer(0.07).timeout
		else:
			# 0 CARDS IN DRAW & DISCARD PILE
			return
			
func trigger_issue_insert(count):
	var card:Card
	for i in range(count):
		card = Cards_Collection.get_random_issue_card_res()
		discard_pile.insert(card)

func trigger_shop_refresh():
	science_node.refresh_shop()

func update_piles():
	draw_pile.update_pile_menu()
	discard_pile.update_pile_menu()
