extends ColorRect

func to_scene(next_scene_path:String):
	var anim_player = $AnimationPlayer
	anim_player.play("scene_trans")
	await anim_player.animation_finished
	get_tree().change_scene_to_file(next_scene_path)
	anim_player.play_backwards("scene_trans")
