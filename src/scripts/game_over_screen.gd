extends Node

var db_enabled: bool = true
var push_to_db: bool = true
var db_ref
var game_ref

@export var panel_node: Panel
@export var output_panel_node: Panel
@export var text_node: RichTextLabel
@export var back_button: Button

func _ready():
	
	$Panel/Desc.text = "You exceeded " + str(GlobalDefines.MAX_POLLUTION_STATE) + " Pollution"
	
	if text_node:
		text_node.text = generate_game_summary_text()
		
	if db_enabled:
		Firebase.Auth.login_with_email_and_password('guest@guest.com','guest123')
	
func _process(delta):
	if panel_node:
		var vp_rect = get_tree().get_root().get_visible_rect()
		panel_node.size = vp_rect.size
		back_button.position.y = vp_rect.size.y * 90 / 100

func generate_game_summary_text() -> String:
	var str = ""
	str += "LASTED "
	str += str(EventController.current_turn)
	str += " TURN/S\n\n"
	
	str += "RESOURCE SCORE: \n"
	str += str(EventController.resource_score)
	str += "\n\n"
	
	str += "HOLDING RESOURCES AT THE END: \n"
	for i in Yield.resource:
		str += str(i)
		str += " : "
		str += str(EventController.latest_resource_value[i])
		str += "\n"
	str += "\n\n"
	
	return str
	
func _on_back_to_menu_pressed():
	push_game_to_db()
	SceneTransition.to_scene("res://src/main_menu_master.tscn")
	queue_free()

func push_game_to_db():
	if push_to_db:
		var timestr:String = str(Time.get_datetime_string_from_system())
		
		game_ref = Firebase.Database.get_database_reference("game", {})

		for i in Yield.resource:
			game_ref.update(timestr+"/resources",{i: EventController.latest_resource_value[i]})
		game_ref.update(timestr,{"turns": EventController.current_turn})
		game_ref.update(timestr,{"rv": EventController.resource_score})

	


	
	
	
