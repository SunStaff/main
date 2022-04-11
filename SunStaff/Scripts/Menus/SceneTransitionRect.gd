extends ColorRect

export(String, FILE, "*.tscn") var next_scene_path

var _anim_player

func transition_to(_next_scene := next_scene_path) -> void:
	# Plays the Fade animation and wait until it finishes
	_anim_player = $AnimationPlayer
	_anim_player.play("Fade")
	print("Transition Played")
	yield(_anim_player, "animation_finished")
	# Changes the scene
	var _null = get_tree().change_scene(_next_scene)
	_anim_player.play_backwards("Fade")
