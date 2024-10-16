extends Node2D

@onready var bgnode = $Background


func _ready():
	# WINDOW SIZE CHANGE
	get_tree().get_root().size_changed.connect(size_change_UI)
	size_change_UI()


func _process(delta):
	pass


func size_change_UI() -> void:
	var vp_size = get_viewport_rect().size
	bgnode.size.x = vp_size.x

func position_change_UI(new_pos: Vector2) -> void:
	self.position = new_pos
