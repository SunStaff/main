extends Area2D

export var ObjectPosition = Vector2()
export var ObjectRotation = 0.0
export var IsInLight = false
var activated
var ObjectRootNode
var ObjectCollisionNode
var ObjectSpriteNode

# Called when the node enters the scene tree for the first time.
func _ready():
	ObjectPosition = self.position
	ObjectRotation = self.rotation
	activated = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func GetObjectPositon():
	return ObjectPosition

func SetObjectPosition(position):
	ObjectPosition = position

func GetObjectRotation():
	return ObjectRotation

func GetObjectLightState():
	return IsInLight

func SetObjectLightState(state):
	IsInLight = state
