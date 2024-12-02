extends Node

var music_enabled: bool = false
var music_volume_mod: float = -16

func _ready():
	EventController.assign_as_sfx_control(self)
	Ost_Collection.load()
	await get_tree().create_timer(4).timeout
	random_music_play()

func play_sfx_clack():
	$Clack.pitch_scale = randf_range(0.7,1.4)
	$Clack.play()

func _input(event):
	if event.is_action_pressed("Debug - Next Music Track"):
		random_music_play()

func random_music_play():
	if music_enabled:
		var mn = $MP
		mn.stream = Ost_Collection.get_random_ost_res()
		mn.volume_db = music_volume_mod
		mn.play()
