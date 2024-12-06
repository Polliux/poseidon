extends Panel

@export var title_n: Node
@export var turn_n: Node
@export var res_n: Node

@export var en_n: Node
@export var sc_n: Node
@export var pr_n: Node
@export var pl_n: Node

signal on_delete_clicked
@export var delete_button: Button
var delete_button_enabled = true

func _ready():
	if !delete_button_enabled:
		delete_button.hide()

func _process(delta):
	pass

func set_value(time_str:String, turn_val:int, res_val:int, res_dict:Dictionary):
	title_n.text = time_str
	turn_n.text = "TURNS : " + str(turn_val)
	res_n.text = "RESOURCE VALUE SCORE : " + str(res_val)
	
	for i in Yield.resource:
		if res_dict.has(i):
			match (i):
				"ENERGY":
					en_n.text = str(res_dict.get(i))
				"SCIENCE":
					sc_n.text = str(res_dict.get(i))
				"PRODUCTION":
					pr_n.text = str(res_dict.get(i))
				"POLLUTION":
					pl_n.text = str(res_dict.get(i))

func _on_delete_button_pressed():
	on_delete_clicked.emit(title_n.text)
