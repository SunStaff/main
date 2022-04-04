extends Area2D


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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
