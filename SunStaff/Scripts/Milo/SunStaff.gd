extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func ChangeLightCircleMonitoring(state):
	self.monitoring = state

func _on_LightCircle_area_entered(area):
	if ("Briar" in area.name):
		area.SetObjectLightState(true)
	if("Lever3" in area.name):
		area.SetObjectLightState(true)

func _on_LightCircle_area_exited(area):
	if ("Briar" in area.name):
		area.SetObjectLightState(false)
	if("Lever3" in area.name):
		area.SetObjectLightState(false)

func _on_LightCircle_body_entered(_body):
	pass

func _on_LightCircle_body_exited(_body):
	pass
