extends Sprite2D

@export_enum ("NORMAL", "SCIENCE") var mode = 0

@onready var state_machine = $"State Machine"
@onready var card_shape_node = $"Card Shape"

@onready var card_res: Card

var fixed:bool = false
var player_interatable:bool = false
var mouse_hover: bool = false
const on_hover_extend: Vector2 = Vector2(0,-35)

var target_pos: Vector2 = Vector2.ZERO
var target_tilt: float = 0

@export var card_height_curve: Curve
@export var card_spread_curve: Curve

@export var discard_pile: Node

const PER_CARD_HORIZONTAL: int = 20
const CARD_HORIZONTAL_MIN_MARGIN: int = 5
const CARD_VERTICAL_OFFSET = 65
const CARD_TILT_RADIAN_MULT: float = 0.25


var lerp_speed: float = 0.07

func _ready():
	# SET LABEL, DESC, IMAGE, COST
	var img = $"Card Shape/Card_Image"
	img.texture = card_res.get_image()
	$"Card Shape/Card Label".set_text(card_res.card_title)
	$"Card Shape/Card Info".set_text(card_res.card_info)
	
	var ctp = card_res.cost_to_play
	var cost: int
	for i in Yield.resource:
		if ctp.has(i):
			cost = ctp.get(i)
			get_node("Card Shape/" + str(i)).text = str(cost)
	
	card_shape_node.set_tooltip_text(card_res.get_title())
	
	
func half_alpha():
	self.modulate.a = 0.5
	
func reset_alpha():
	self.modulate.a = 1.0

func _process(delta):

	if !fixed:
		if state_machine.current_state.name.to_lower() != "card_dragging":
			self.position = lerp(self.position,target_pos,lerp_speed)
			self.rotation = lerp(self.rotation,target_tilt,lerp_speed)
	

func update_on_hand_pos() -> void:
	
	if !fixed:
		var hand = get_parent().get_child_count()
		var index = get_index()
		var ratio: float = 0.5
		
		if hand == 2:
			ratio = 0.25 + (float(index) * 0.50)
		elif hand > 2:
			ratio = float(index)/float(hand-1)
			
		var target_position: Vector2 = Vector2.ZERO
		var target_tilt_p: float = 0
		
		# CARD POSITION
		target_position.x = ((ratio-0.5) * CARD_HORIZONTAL_MIN_MARGIN) * (hand * PER_CARD_HORIZONTAL)
		target_position.y = -card_height_curve.sample(ratio) * CARD_VERTICAL_OFFSET
		
		# ON MOUSE HOVER
		if mouse_hover:
			target_position += on_hover_extend
			self.z_index += 20
		else:
			self.z_index = 0
		target_pos = target_position
		
		# CARD TILT
		target_tilt_p = card_spread_curve.sample(ratio) * CARD_TILT_RADIAN_MULT
		target_tilt = target_tilt_p
		

func _on_card_shape_mouse_entered():
	
	if !fixed:
		mouse_hover = true
		update_on_hand_pos()
		if mode == 0 and state_machine.current_state.name.to_lower() == "card_neutral":
			EventController.get_sfx_control().play_sfx_clack()

func _on_card_shape_mouse_exited():
	if !fixed:
		mouse_hover = false
		update_on_hand_pos()
	
func _on_card_shape_gui_input(event):
	if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		if player_interatable and !fixed:
			$"State Machine/Card_Neutral".To_Clicked()
		
func card_play_pay() -> bool:
	var ctp = card_res.cost_to_play
	for i in ctp:
		if not EventController.get_ui_control().get_resource_value(i) >= ctp[i]:
			return false
			
	return true

func card_pay() -> void:
	var ctp = card_res.cost_to_play
	for i in ctp:
		EventController.get_ui_control().modify_resource_value(i,ctp[i],-1)

	
func on_card_played():
	discard()

func discard():
	EventController.game_control_node.add_to_discard_pile(card_res)
	queue_free()
	discard_pile_animate()

func discard_pile_animate():
	if discard_pile:
		target_pos = discard_pile.position + Vector2(0,-600)
		await get_tree().create_timer(0.50).timeout
	queue_free()
	
	
func on_buy_attempt() -> bool:
	print("DEBUG")
	if (EventController.get_ui_control().get_resource_value("SCIENCE") >= card_res.current_science_buy_cost):
		EventController.get_ui_control().modify_resource_value("SCIENCE",card_res.current_science_buy_cost,-1)
		self.discard()
		return true
	else:
		return false

func force_neutral() -> void:
	state_machine.on_child_transition(null,"card_neutral")
