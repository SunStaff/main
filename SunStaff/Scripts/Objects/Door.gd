extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func OpenDoor():
	var frontDoor = $FrontDoor
	var backDoor = $BackDoor
	var collider = $CollisionShape2D
	frontDoor.playing = true
	backDoor.playing = true
	collider.set_deferred("disabled", true)

func CloseDoor():
	var frontDoor = $FrontDoor
	var backDoor = $BackDoor
	var collider = $CollisionShape2D
	frontDoor.playing = false
	frontDoor.frame = 0
	backDoor.playing = false
	backDoor.frame = 0
	collider.set_deferred("disabled", false)

