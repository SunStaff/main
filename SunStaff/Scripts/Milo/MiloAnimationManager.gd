extends Node

var MiloHasStaff
var StateMachine
var runSpeed
var marginErrorVec

func UpdateAnimations(stateMachine, hasStaff, velocity, playLeftOrRight, speed, MARGIN_OF_ERROR):
	StateMachine = stateMachine
	MiloHasStaff = hasStaff
	runSpeed = speed * 2
	marginErrorVec = Vector2(MARGIN_OF_ERROR, MARGIN_OF_ERROR)
	if (velocity > -marginErrorVec and velocity < marginErrorVec):
		if (MiloHasStaff):
			StateMachine.travel("Idle_Staff")
		else:
			StateMachine.travel("Idle_Staffless")
	if (playLeftOrRight and (velocity.x > MARGIN_OF_ERROR or velocity.x < -MARGIN_OF_ERROR)):
		if (MiloHasStaff):
			if (velocity.x > runSpeed or velocity.x < -runSpeed):
				StateMachine.travel("Run_Staff")
			else:
				StateMachine.travel("Walk_Staff")
		else:
			if (velocity.x > runSpeed or velocity.x < -runSpeed):
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
