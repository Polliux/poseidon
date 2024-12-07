extends Control

@export var cards_shelf: Node
@export var card_frame: PackedScene
@export var state_machine: Node


const LERP_SPEED:float = 0.30
const GAP_MARGIN:float = 20

const RAND_MIN:float = 0.70
const RAND_MAX:float = 1.10

var target_pos:Vector2
var outer_margin = 30

func _ready():
	state_machine.state_changed.connect(on_game_state_change)
	Cards_Collection.load()
	generate_3_random_cards()
	update_hand_pos()
	
func _process(delta):
	
	self.position = lerp(self.position,target_pos,LERP_SPEED)
	update_hand_pos()

func _input(event):
	if event.is_action_pressed("Research"):
		get_parent()._on_toggle_science_shop_pressed()
	
func generate_3_random_cards() -> void:

	for i in range(3):
		var new_card = card_frame.instantiate()
		var card_inst
		while (!card_inst) or (!card_inst.appear_in_shop):
			card_inst = Cards_Collection.get_random_card_res()
		new_card.card_res = card_inst
		new_card.mode = 1
		new_card.lerp_speed = 0.30
		new_card.target_pos = Vector2(50+(50*i),self.position.y+100)
		cards_shelf.add_child(new_card)
		
		new_card.card_res.current_science_buy_cost = roundi(new_card.card_res.science_buy_cost * randf_range(RAND_MIN,RAND_MAX))
		
		var offset: Vector2 = Vector2(70,-90)
		
		var new_panel = Panel.new()
		new_panel.size = Vector2(50,40)
		
		var new_label = Label.new()
		new_label.text = str(new_card.card_res.current_science_buy_cost)
		new_label.set("theme_override_colors/font_color",Color.ROYAL_BLUE)
		new_label.set("theme_override_font_sizes/font_size",30)
		
		new_panel.position = new_card.position + offset
		new_label.position = new_card.position + offset
		new_card.add_child(new_panel)
		new_card.add_child(new_label)
		
	update_hand_pos()
	
func size_change_UI(vp_size:Vector2, gui_toggle:bool) -> void:
	
	self._set_size(vp_size/2)
	var new_pos:Vector2 = Vector2.ZERO
	new_pos = new_pos + vp_size/2
	new_pos.x -= (self.get_size().x/2)
	new_pos.y = (self.get_size().y * 85/100)
	
	outer_margin = 30
	
	if not gui_toggle:
		new_pos.x -= vp_size.x
	target_pos = new_pos
	update_hand_pos()

func update_hand_pos():
	var passed_size: Vector2 = self.size
	passed_size.y = passed_size.y / 2
	
	cards_shelf.update_hand_position(passed_size)

func on_game_state_change(old_state,new_state):
	if str(new_state).to_lower() == "neutral":
		cards_shelf.toggle_interactable(true)
	else:
		cards_shelf.toggle_interactable(false)
		
func refresh_shop():
	for i in range(cards_shelf.get_child_count()):
		if cards_shelf.get_child(i):
			cards_shelf.get_child(i).queue_free()
	generate_3_random_cards()
