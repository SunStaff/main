extends Area2D

var activated
var playerRootNode

# Called when the node enters the scene tree for the first time.
func _ready():
	activated = false
	playerRootNode = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LightCircle_body_entered(body):
	pass


func _on_LightCircle_body_exited(body):
	pass


func _on_LightCircle_area_entered(area):
	if (area.name == "Briar"):
		activated = true
		area.SetObjectLightState(true)


func _on_LightCircle_area_exited(area):
	if (area.name == "Briar"):
		activated = false
		area.SetObjectLightState(false)
