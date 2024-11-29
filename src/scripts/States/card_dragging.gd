extends State
class_name Card_Dragging

var card
var target_pos = Vector2.ZERO

const LERP_SPEED: float = 0.12

func Enter():
	target_pos = card.position
	card.half_alpha()
	print("Dragging")
	
func Update(delta):
	card.position = lerp(card.position,target_pos,LERP_SPEED)
	card.rotation = lerp(card.rotation,0.0,LERP_SPEED)
	
func UpdateInputEvent(event):
	if event is InputEventMouseMotion:
		#card.scale = Vector2(0.5,0.5)
		target_pos += event.relative
		pass
	
	# PLACED OR DEFAULT TO NEUTRAL
	if (Input.is_action_just_released("Right Click") or (Input.is_action_just_pressed("Right Click"))):
		Transitioned.emit(self,"Card_Neutral")
		return
		
	if Input.is_action_just_released("Left Click"):
		Transitioned.emit(self,"Card_Placed")
		return
		
		
