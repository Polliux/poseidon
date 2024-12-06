extends Node

@export var panel_node: Panel
@export var output_node: Panel
@export var back_button: Button

@export var records_box: Node

const CARD_SIZE = Vector2(150,220)
const DISPLAY_SCALE = 1.00

func _ready():
	get_tree().get_root().size_changed.connect(window_resized)
	window_resized()
	Cards_Collection.load()
	load_cards()
	
func window_resized():
	if panel_node:
		var vp_rect = get_tree().get_root().get_visible_rect()
		panel_node.size = vp_rect.size
		back_button.position.y = vp_rect.size.y * 90 / 100
		
		var new_x = 0
		while (new_x + (CARD_SIZE.x*DISPLAY_SCALE*1.02) <= (vp_rect.size.x*0.92)):
			new_x += CARD_SIZE.x*DISPLAY_SCALE *1.01
		output_node.size.x = new_x
		output_node.size.y =  vp_rect.size.y * 90 / 100
		output_node.position.x = vp_rect.size.x * 8 / 100
		output_node.position.y = vp_rect.size.y * 4 / 100
	
func _process(delta):
	pass
	
func _on_back_to_menu_pressed():
	SceneTransition.to_scene("res://src/main_menu_master.tscn")
	queue_free()

func load_cards():
	var dict = Cards_Collection.get_card_collection()
	var cardframe = preload("res://src/scenes/card.tscn")
	print(dict)
	
	for i in range(5):
		for card in dict:
			var control_node = Control.new()
			var new_cardframe = cardframe.instantiate()
			
			control_node.custom_minimum_size = CARD_SIZE*DISPLAY_SCALE
			new_cardframe.position += CARD_SIZE/2*DISPLAY_SCALE
			new_cardframe.scale = Vector2(DISPLAY_SCALE,DISPLAY_SCALE)
			new_cardframe.card_res = dict.get(card)
			new_cardframe.fixed = true
			
			records_box.add_child(control_node)
			control_node.add_child(new_cardframe)




	
