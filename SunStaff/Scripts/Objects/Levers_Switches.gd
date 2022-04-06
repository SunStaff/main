extends "res://Scripts/Objects/Interactable.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isTurnedOn = false
export (bool) var isInLight = true
var LeverManager



# Called when the node enters the scene tree for the first time.
func _ready():
	LeverManager = get_node("/root/LeverManager")

#When the switch is interacted with, change lever state from ON to OFF, or OFF to ON.
func _change_lever_state():
	isTurnedOn = not isTurnedOn
	LeverManager.LeverFlipped(GameManager.GetCurrentLevel(), self, isTurnedOn)

#Get lever's position
func _get_position():
	return position

#Set lever's position
func _set_position(x, y):
	position = Vector2(x, y)

func SetObjectLightState(state): # What to do if object only appears in dark but not light
	IsInLight = state
	if (IsInLight && !activated):
		activated = true
		get_node("LitLever").visible = false #TODO: Change "Sprite" to "UnlitLever"
		get_node("LitLeverHandle").visible = false
		self.set_deferred("monitoring", false)
	else:
		get_node("LitLever").visible = true #TODO: Change "Sprite" to "UnlitLever"
		get_node("LitLeverHandle").visible = true
		activated = false
		self.set_deferred("monitoring", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
