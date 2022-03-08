extends "res://Scripts/Objects/Interactable.gd"

var duplicateSprite
var activated
func _ready():
	activated = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func HurtPlayer():
	GameManager.SetPlayerAliveState(false)

func _on_Briar_body_entered(body):
	if (body.name == "Milo"):
		HurtPlayer()

func SetObjectLightState(state): # What to do if object only appears in dark but not light
	IsInLight = state
	if (IsInLight && !activated):
		activated = true
		get_node("Sprite").visible = false
		self.set_deferred("monitoring", false)
	else:
		get_node("Sprite").visible = true
		activated = false
		self.set_deferred("monitoring", true)
