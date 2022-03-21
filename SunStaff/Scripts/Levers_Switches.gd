extends Area2D

var isTurnedOn = false
export (bool) var isInLight = true
#Sets a signal name for the object in the editor
export (String) var signalName = ""




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#When the switch is interacted with, change lever state from ON to OFF, or OFF to ON.
func _change_lever_state():
	isTurnedOn = !isTurnedOn
	#Sends out signal to tell external object what to do.
	emit_signal(signalName, isTurnedOn)

#Get lever's position
func _get_position():
	return position

#Set lever's position
func _set_position(x, y):
	position = Vector2(x, y)

func _on_body_entered():
	if Input.is_action_pressed("Interact"):
		_change_lever_state()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
