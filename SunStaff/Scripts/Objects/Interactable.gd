extends Area2D

export var ObjectPosition = Vector2()
export var ObjectRotation = 0.0
export var IsInLight = false
export var PlayerWithinRange = false
var GameManager

# Called when the node enters the scene tree for the first time.
func _ready():
	#ObjectPosition = self.position
	#ObjectRotation = self.rotation
	GameManager = get_node("/root/GameManager")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func GetObjectPositon():
	return ObjectPosition

func GetObjectRotation():
	return ObjectRotation

func GetObjectLightState():
	return IsInLight

func GetPlayerIsInRange():
	return PlayerWithinRange