extends Sprite2D

@export_enum ("NORMAL", "SCIENCE") var mode = 0

@onready var state_machine = $"State Machine"
@onready var card_shape_node = $"Card Shape"

@onready var card_res: Card

var mouse_hover: bool = false
const on_hover_extend: Vector2 = Vector2(0,-35)

var target_pos: Vector2 = Vector2(0,0)
var target_tilt: float = 0

@export var card_height_curve: Curve
@export var card_spread_curve: Curve

const PER_CARD_HORIZONTAL: int = 20
const CARD_HORIZONTAL_MIN_MARGIN: int = 5
const CARD_VERTICAL_OFFSET = 65
const CARD_TILT_RADIAN_MULT: float = 0.25



const LERP_SPEED: float = 0.07

func _ready():
	# SET LABEL, DESC, IMAGE
	var img = Sprite2D.new()
	img.position = self.position + Vector2(0,-51)
	img.texture = card_res.get_image()
	add_child(img)
	$"Card Shape/Card Label".set_text(card_res.card_title)
	$"Card Shape/Card Info".set_text(card_res.card_info)
	
	card_shape_node.set_tooltip_text(card_res.get_title())
	
func half_alpha():
	self.modulate.a = 0.5
	
func reset_alpha():
	self.modulate.a = 1.0

func _process(delta):

	if state_machine.current_state.name.to_lower() != "card_dragging":
		self.position = lerp(self.position,target_pos,LERP_SPEED)
		self.rotation = lerp(self.rotation,target_tilt,LERP_SPEED)
	

func update_on_hand_pos() -> void:
	
	if mode == 0:

		var hand = get_parent().get_child_count()
		var index = get_index()
		var ratio: float = 0.5
		
		if hand == 2:
			ratio = 0.25 + (float(index) * 0.50)
		elif hand > 2:
			ratio = float(index)/float(hand-1)
			
		var target_position: Vector2 = Vector2(0,0)
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
	mouse_hover = true
	update_on_hand_pos()

func _on_card_shape_mouse_exited():
	mouse_hover = false
	update_on_hand_pos()
	
func _on_card_shape_gui_input(event):
	if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		$"State Machine/Card_Neutral".To_Clicked()
		
func on_card_played():
	discarded()

func discarded():
	EventController.game_control_node.add_to_discard_pile(card_res)
	queue_free()
