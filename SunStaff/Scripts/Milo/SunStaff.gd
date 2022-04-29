extends Area2D

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
		body.SetObjectLightState(true)

func _on_LightCircle_body_exited(body):
	if (body.is_in_group("UnlitOnly")):
		body.SetObjectLightState(false)
