extends Node

var music_enabled: bool = true
var music_volume_mod: float = -18
var music_volume_ratio: float = 1.00

func _ready():
	EventController.assign_as_sfx_control(self)
	Ost_Collection.load()
	await get_tree().create_timer(2).timeout
	random_music_play()

func play_sfx_clack():
	$Clack.pitch_scale = randf_range(0.7,1.4)
	$Clack.play()

func _input(event):
	if event.is_action_pressed("Debug - Next Music Track"):
		random_music_play()
		
	if event.is_action_pressed("Volume Up"):
		music_volume_mod = clampf(music_volume_mod+2,-30,-10)
		update_volume()
	elif event.is_action_pressed("Volume Down"):
		music_volume_mod = clampf(music_volume_mod-2,-30,-10)
		update_volume()
		
func update_volume():
	$MP.volume_db = music_volume_mod
	if music_volume_mod <= -28:
		$MP.stop()
	else:
		if !$MP.playing:
			$MP.play()

		
func random_music_play():
	if music_enabled:
		var mn = $MP
		mn.stream = Ost_Collection.get_random_ost_res()
		mn.volume_db = music_volume_mod
		mn.play()


func _on_mp_finished():
	await get_tree().create_timer(2).timeout
	random_music_play()
