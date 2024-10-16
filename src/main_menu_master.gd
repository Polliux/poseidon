extends Node2D

var db_enabled = false
var db_ref
var tile_ref
@onready var dashboard = $PanelContainer/VBoxContainer/RichTextLabel

func _ready():
	if db_enabled:
		Firebase.Auth.login_succeeded.connect(on_login_succeed)
		Firebase.Auth.signup_succeeded.connect(on_signup_succeed)
		Firebase.Auth.login_failed.connect(on_login_failed)
		Firebase.Auth.signup_failed.connect(on_signup_failed)
		
		Firebase.Auth.login_with_email_and_password('guest@guest.com','guest123')

func _process(delta):
	pass

# MENU NAVIGATION
func _on_start_pressed():
	var game = preload("res://src/scenes/game_control.tscn").instantiate()
	get_tree().root.add_child(game)

	queue_free()

func _on_exit_pressed():
	get_tree().quit()

# FIREBASE REALTIME DB TEST
func _on_add_pressed():
	var key = $PanelContainer/VBoxContainer/BoxContainer/HBoxContainer/TextEdit.text
	var value = $PanelContainer/VBoxContainer/BoxContainer/HBoxContainer/TextEdit2.text
	tile_ref.update("",{key: value})

func _on_remove_pressed():
	pass # Replace with function body.
	
# ON DATA CHANGES
func _on_new_data_updated(data):
	print("new data")
	print(data)
	update_dashboard(data)
	
func _on_patch_data_updated(data):
	print("patch data")
	print(data)
	update_dashboard(data)
	
# ON LOGIN/SIGNUP 
func on_login_succeed(auth):
	print("login success")
	print(auth)
	load_db()
func on_signup_succeed(auth):
	print("signup success")
	print(auth)
	load_db()
func on_login_failed(error_code, message):
	print(error_code)
	print(message)
func on_signup_failed(error_code, message):
	print(error_code)
	print(message)

# LOAD DB
func load_db():
	db_ref = Firebase.Database.get_database_reference("")
	
	#var exa = Firebase.Database.get_database_reference("data", {})
	tile_ref = Firebase.Database.get_database_reference("tile", {})
	
	db_ref.new_data_update.connect(_on_new_data_updated)
	db_ref.patch_data_update.connect(_on_patch_data_updated)
	
func update_dashboard(data):
	
	dashboard.text = ""
	
	var fulldb = db_ref.get_data()
	
	dashboard.text = recurv_parser(fulldb,0)
	
# RECURSIVE JSON TO STR PARSER
# REUSE
func recurv_parser(dict,indent):
	var str: String
	var list = dict.keys()
	
	for n in range(list.size()):
		
		if indent > 0:
			for y in range(indent):
				str += "\t"
			
		if (type_string(typeof(dict.get(list[n]))) == "Dictionary"):
			str += list[n]
			str += "\n"
			str += recurv_parser(dict.get(list[n]),indent+1)
		else:
			str += list[n]
			str += " "
			str += str(dict.get(list[n]))
			str += "\n"
		
	print(str)
	return str
