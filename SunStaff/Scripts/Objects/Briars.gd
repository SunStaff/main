extends "res://Scripts/Objects/Interactable.gd"

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func HurtPlayer():
	GameManager.SetPlayerAliveState(false)
