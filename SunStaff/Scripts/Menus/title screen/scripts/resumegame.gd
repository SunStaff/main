extends Control

var pause
var options
func _unhandled_input(event):
	if ((event.is_action_pressed("pause") and not GameManager.GemSelectionScreenOpen) and !options):
		self.is_paused = !is_paused
		get_node("options menu/VBoxContainer").visible = false
		get_node("options menu/OPTIONS").visible = false

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

func _on_options_pressed():
	options = true
	get_node("paused menu/VBoxContainer").visible = false
	get_node("paused menu/paused").visible = false
	get_node("options menu/VBoxContainer").visible = true
	get_node("options menu/OPTIONS").visible = true
	
func _on_back_to_pause_pressed():
	options = false
	get_node("paused menu/VBoxContainer").visible = true
	get_node("paused menu/paused").visible = true
	get_node("options menu/VBoxContainer").visible = false
	get_node("options menu/OPTIONS").visible = false

func _on_Restart_pressed():
	GameManager.TeleportPlayer()
	_on_resume_pressed()
