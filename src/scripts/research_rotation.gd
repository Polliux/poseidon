extends Control

@export var cards_shelf: Node
@export var card_frame: PackedScene

const LERP_SPEED:float = 0.30

var target_pos:Vector2

func _ready():
	Cards_Collection.load()
	generate_3_random_cards()
	pass 
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if not position.is_equal_approx(target_pos):
		self.position = lerp(self.position,target_pos,LERP_SPEED)

#func get_size() -> Vector2:
#	return $Panel.size
	
func generate_3_random_cards() -> void:

	for i in range(3):
		var new_card = card_frame.instantiate()
		new_card.card_res = Cards_Collection.get_random_card_res()
		new_card.mode = 1
		new_card.target_pos = Vector2(50+(50*i),self.position.y+100)
		cards_shelf.add_child(new_card)
	
