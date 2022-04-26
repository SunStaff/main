extends "res://Scripts/Objects/Interactable.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isTurnedOn = false
var LeverManager
var PlayerWithinRange = false
onready var shader = self.material

# Called when the node enters the scene tree for the first time.
func _ready():
	LeverManager = get_node("/root/LeverManager")

#When the switch is interacted with, change lever state from ON to OFF, or OFF to ON.
func _change_lever_state():
	isTurnedOn = not isTurnedOn
	if(isTurnedOn == true):
		get_child(0).get_child(0).rotation = 45
		get_child(0).get_child(0).position.x *= -1
		get_child(1).get_child(0).rotation = 45
		get_child(1).get_child(0).position.x *= -1
	elif(!isTurnedOn):
		get_child(0).get_child(0).rotation = -45
		get_child(0).get_child(0).position.x *= -1
		get_child(1).get_child(0).rotation = -45
		get_child(1).get_child(0).position.x *= -1
	LeverManager.LeverFlipped(GameManager.GetCurrentLevel(), self, isTurnedOn)

#Get lever's position
func GetPosition():
	return position

#Set lever's position
func SetPosition(x, y):
	position = Vector2(x, y)

func SetObjectLightState(state): # What to do if object only appears in dark but not light
	IsInLight = state

	if("Lever3" in self.name):
		get_child(0).get_child(0).visible = !state
		get_child(0).get_child(1).visible = !state
		self.set_deferred("monitoring", !state)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	GlowMaterial(false)
	if (PlayerWithinRange):
		GlowMaterial(true)
		if (Input.is_action_just_pressed("Interact")):
			if (LeverManager.GetCurrentClosestLever(GameManager.GetLevers(), GameManager.GetPlayer()) == self):
				_change_lever_state()

func _on_Lever_body_entered(body):
	if ("Milo" in body.name):
		PlayerWithinRange = true

func _on_Lever_body_exited(body):
	if ("Milo" in body.name):
		PlayerWithinRange = false

func GlowMaterial(state):
	if (state):
		shader.set_shader_param("color", Color(1,1,1,0.75))
	else:
		shader.set_shader_param("color", Color(1,1,1,0))
