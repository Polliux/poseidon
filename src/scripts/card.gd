extends Node2D

var target_pos: Vector2 = Vector2(0,0)
var target_tilt: float = 0

const LERP_SPEED: float = 0.05

func _ready():
	pass # Replace with function body.


func _process(delta):
	self.position = lerp(self.position,target_pos,LERP_SPEED)
	self.rotation = lerp(self.rotation,target_tilt,LERP_SPEED)
