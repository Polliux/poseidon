extends Node

var db_enabled = true
var db_ref
var game_ref

var push_to_db: bool = true

var records_dict: Dictionary = {}

@export var panel_node: Panel
@export var output_node: Panel
@export var back_button: Button

@export var records_box: VBoxContainer


func _ready():
	
	get_tree().get_root().size_changed.connect(window_resized)
	window_resized()
	if db_enabled:
		Firebase.Auth.login_succeeded.connect(on_login_succeed)
		Firebase.Auth.signup_succeeded.connect(on_signup_succeed)
		Firebase.Auth.login_failed.connect(on_login_failed)
		Firebase.Auth.signup_failed.connect(on_signup_failed)
		
		Firebase.Auth.login_with_email_and_password('guest@guest.com','guest123')
	
func window_resized():
	if panel_node:
		var vp_rect = get_tree().get_root().get_visible_rect()
		panel_node.size = vp_rect.size
		back_button.position.y = vp_rect.size.y * 90 / 100
		
		output_node.size.x = vp_rect.size.x * 70 / 100
		output_node.size.y =  vp_rect.size.y * 90 / 100
		output_node.position.x = vp_rect.size.x * 25 / 100
		output_node.position.y = vp_rect.size.y * 4 / 100
		
func _process(delta):
	pass
	
func _on_back_to_menu_pressed():
	SceneTransition.to_scene("res://src/main_menu_master.tscn")
	queue_free()

# ON DATA CHANGES
func _on_new_data_updated(data):
	print("new data")
	print(data)
	from_db_updated_data(data)
	
func _on_patch_data_updated(data):
	print("patch data")
	print(data)
	#from_db_updated_data(data)
	
# ON LOGIN/SIGNUP 
func on_login_succeed(auth):
	print("login success")
	#print(auth)
	load_db()
	
func on_signup_succeed(auth):
	print("signup success")
	print(auth)
	
func on_login_failed(error_code, message):
	print(error_code)
	print(message)
func on_signup_failed(error_code, message):
	print(error_code)
	print(message)

# LOAD DB & DATA
func load_db():

	game_ref = Firebase.Database.get_database_reference("game", {})
	
	game_ref.new_data_update.connect(_on_new_data_updated)
	#game_ref.patch_data_update.connect(_on_patch_data_updated)
	
func pass_delete_to_db(ref):
	if !game_ref:
		return
	records_dict.erase(ref)
	game_ref.delete(ref)
	
	
func from_db_new_data(data):
	records_dict[data.key] = data.data
	display_record(records_dict)

func from_db_updated_data(data):
	if str(data).contains("/"):
		var arr = str(data.key).split("/")
		match arr.size():
			2:
				records_dict[arr[0]][arr[1]] = data.data
			3:
				records_dict[arr[0]][arr[1]][arr[2]] = data.data
		print(str)
		display_record(records_dict)
		return
	records_dict.get_or_add(data.key)
	records_dict[data.key] = data.data
	display_record(records_dict)
	
func display_record(dict:Dictionary):
	
	for i in records_box.get_child_count():
		records_box.get_child(i).queue_free()
		
	var record_scene = preload("res://src/scenes/indiv_record.tscn")
	for i in dict:
		var rec = record_scene.instantiate()
		if dict.get(i):
			rec.set_value(i,dict.get(i).get("turns"),dict.get(i).get("rv"),dict.get(i).get("resources"))
			rec.on_delete_clicked.connect(pass_delete_to_db.bind())
			records_box.add_child(rec)
	
