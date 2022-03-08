extends Area2D

var activated


# Called when the node enters the scene tree for the first time.
func _ready():
	activated = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LightCircle_body_entered(body):
	pass


func _on_LightCircle_body_exited(body):
	pass


func _on_LightCircle_area_entered(area):
	if (!activated):
		activated = true
		area.SetObjectLightState(true)


func _on_LightCircle_area_exited(area):
	if (activated):
		activated = false
		area.SetObjectLightState(false)
