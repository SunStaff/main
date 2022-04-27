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
	if (area.is_in_group("UnlitOnly")):
		area.SetObjectLightState(true)
	if ("UnlitOnlyPlatform" in area.name):
		area.SetObjectLightState(true)

func _on_LightCircle_area_exited(area):
	if ("Briar" in area.name):
		area.SetObjectLightState(false)
	if (area.is_in_group("UnlitOnly")):
		area.SetObjectLightState(false)
	if ("UnlitOnlyPlatform" in area.name):
		area.SetObjectLightState(false)

func _on_LightCircle_body_entered(body):
	if (body.is_in_group("UnlitOnly")):
		print("body entered")
		body.SetObjectLightState(true)

func _on_LightCircle_body_exited(body):
	if (body.is_in_group("UnlitOnly")):
		print("body exited")
		body.SetObjectLightState(false)
