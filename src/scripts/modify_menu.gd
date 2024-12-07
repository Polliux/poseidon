extends Control

@export var title_n: Label
@export var turn_n: SpinBox
@export var res_value_n: SpinBox
@export var en_n: SpinBox
@export var sc_n: SpinBox
@export var pr_n: SpinBox
@export var pl_n: SpinBox

@export var confirm_bt: Button
@export var cancel_bt: Button

signal on_confirm

func _ready():
	var vp_rect = get_tree().get_root().get_visible_rect()
	self.size = vp_rect.size
	
	var pn = $Panel
	
	pn.size = get_minimum_size()
	pn.position.x = vp_rect.size.x * 0.20
	pn.position.y = vp_rect.size.y * 0.20

func set_prev(title, turns, res_value, en, sc, pr, pl):
	title_n.text = title
	turn_n.value = turns
	res_value_n.value = res_value
	en_n.value = en
	sc_n.value = sc
	pr_n.value = pr
	pl_n.value = pl

func _process(delta):
	pass

func _on_cancel_button_pressed():
	self.queue_free()

func _on_confirm_button_pressed():
	on_confirm.emit(title_n.text,turn_n.value,res_value_n.value,en_n.value,sc_n.value,pr_n.value,pl_n.value)
	self.queue_free()
