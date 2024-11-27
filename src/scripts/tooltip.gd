extends PopupPanel

@onready var rtl_node = $Panel/MarginContainer/RichTextLabel

func _ready():
	pass 

func _process(delta):
	pass

func text(text):
	rtl_node.text = text
