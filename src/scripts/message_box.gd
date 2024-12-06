extends Node2D

@export var lb: Label
@export var ctl: Control

var float_up_speed = 1

func _ready():
	var vp_size = get_viewport_rect().size
	self.position = vp_size
	self.position.x -= vp_size.x * 0.4
	self.position.y += vp_size.y * 0.1
	lb.set("theme_override_colors/font_color",Color.CRIMSON)

func _process(delta):
	self.position.y -= float_up_speed
	self.modulate.a -= 1

	
func set_message(str:String):
	lb.set_text(str)
