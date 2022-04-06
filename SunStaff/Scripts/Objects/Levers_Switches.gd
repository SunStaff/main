extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isTurnedOn = false
export (bool) var isInLight = true
var LeverManager
var PlayerWithinRange = false


# Called when the node enters the scene tree for the first time.
func _ready():
	LeverManager = get_node("/root/LeverManager")

#When the switch is interacted with, change lever state from ON to OFF, or OFF to ON.
func ChangeLeverState():
	isTurnedOn = !isTurnedOn
	LeverManager.LeverFlipped(GameManager.GetCurrentLevel(), self, isTurnedOn)

#Get lever's position
func GetPosition():
	return position

#Set lever's position
func SetPosition(x, y):
	position = Vector2(x, y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (PlayerWithinRange):
		if (Input.is_action_just_pressed("Interact")):
			if (LeverManager.GetCurrentClosestLever(GameManager.GetLevers(), GameManager.GetPlayer()) == self):
				ChangeLeverState()

func _on_Lever_body_entered(body):
	if ("Milo" in body.name):
		PlayerWithinRange = true

func _on_Lever_body_exited(body):
	if ("Milo" in body.name):
		PlayerWithinRange = false
