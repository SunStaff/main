extends Control

func _unhandled_input(event):
	if (event.is_action_pressed("pause") and not GameManager.GemSelectionScreenOpen):
		self.is_paused = !is_paused

var is_paused = false setget set_is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused


func _on_resume_pressed():
	self.is_paused = false

func _on_back_to_menu_pressed():
	self.is_paused = false
	GameManager.SceneTransition.transition_to("res://Scenes/Menus/MainMenu.tscn")
