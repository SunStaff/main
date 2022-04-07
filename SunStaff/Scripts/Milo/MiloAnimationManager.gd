extends Node

var MiloHasStaff
var StateMachine

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func UpdateAnimations(stateMachine, hasStaff, velocity, playLeftOrRight):
	StateMachine = stateMachine
	MiloHasStaff = hasStaff
	if (velocity.length() == 0):
		if (MiloHasStaff):
			StateMachine.travel("Idle_Staff")
		else:
			StateMachine.travel("Idle_Staffless")
	if (playLeftOrRight and (velocity.x > 0 or velocity.x < 0)):
		if (MiloHasStaff):
			if (velocity.x > 600 or velocity.x < -600):
				StateMachine.travel("Run_Staff")
			else:
				StateMachine.travel("Walk_Staff")
		else:
			if (velocity.x > 600 or velocity.x < -600):
				StateMachine.travel("Run_Staffless")
			else:
				StateMachine.travel("Walk_Staffless")

func JumpAnimation():
	if (MiloHasStaff):
		StateMachine.travel("Jump_Staff")
	else:
		StateMachine.travel("Jump_Staffless")

func FallAnimation():
	if (MiloHasStaff):
		StateMachine.travel("Fall_Staff")
	else:
		StateMachine.travel("Fall_Staffless")
