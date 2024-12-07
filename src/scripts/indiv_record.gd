extends Panel

@export var title_n: Label
@export var turn_n: Node
@export var res_n: Node

@export var en_n: Node
@export var sc_n: Node
@export var pr_n: Node
@export var pl_n: Node

var outer_node: Node

var turn: int
var res_value: int

signal on_delete_clicked

var modify_button_enabled = false
@export var modify_button: Button
var delete_button_enabled = false
@export var delete_button: Button

func _ready():
	if !delete_button_enabled:
		delete_button.hide()
	if !modify_button_enabled:
		modify_button.hide()

func _process(delta):
	pass

func set_value(time_str:String, turn_val:int, res_val:int, res_dict:Dictionary):
	title_n.text = time_str
	turn = turn_val
	turn_n.text = "TURNS : " + str(turn_val)
	res_value = res_val
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

func _on_modify_button_pressed():
	var board = load("res://src/scenes/modify_menu.tscn").instantiate()
	board.on_confirm.connect(submitted_change)
	board.set_prev(title_n.text,turn,res_value,int(en_n.text),int(sc_n.text),int(pr_n.text),int(pl_n.text))
	outer_node.add_child(board)
	
func submitted_change(title,turns,resource_value,en,sc,pr,pl):
	
	if turns != self.turn:
		outer_node.push_update(title,{"turns":turns})
	if resource_value != self.res_value:
		outer_node.push_update(title,{"rv":resource_value})
	if en != int(en_n.text):
		outer_node.push_update(title+"/resources",{"ENERGY":en})
	if sc != int(sc_n.text):
		outer_node.push_update(title+"/resources",{"SCIENCE":sc})
	if pr != int(pr_n.text):
		outer_node.push_update(title+"/resources",{"PRODUCTION":pr})
	if pl != int(pl_n.text):
		outer_node.push_update(title+"/resources",{"POLLUTION":pl})
