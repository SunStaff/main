extends KinematicBody2D

# Node Variables
var playerRootNode
var sprite
var spriteUnlit
const MARGIN_OF_ERROR = 0.008

# SunStaff Variables
var HasStaff = true
export (bool) var TurnLightOff = false

#Animation Variables
var AnimationManager
var StateMachine
var playLeftOrRight = false

# Movement Variables
var faceRight = true
export (float) var speed = 600.0
var velocity = Vector2.ZERO
var direction

# Jump Variables
var justJumped = false
export (float) var jump_speed = -1600
export (float) var gravity = 3000

func _ready():
	if (GameManager.ChangeSceneCalled):
		GameManager.GetNewInstancesOfVariables()
		GameManager.ChangeSceneCalled = false
	if (TurnLightOff):
		GameManager.GetSunStaff().visible = false
	playerRootNode = get_parent()
	sprite = $Lit
	spriteUnlit = $Unlit
	spriteUnlit.visible = false
	AnimationManager = load("res://Scripts/Milo/MiloAnimationManager.gd").new()
	StateMachine = $AnimationTree.get("parameters/playback")

func get_input():
	velocity.x = 0.0

	if (is_on_floor()):
		playLeftOrRight = true

	if Input.is_action_pressed("Right"):
		velocity.x += speed
		sprite.scale.x = 1
		spriteUnlit.scale.x = 1
		direction = 1
	
	elif Input.is_action_pressed("Left"):
		velocity.x -= speed
		sprite.scale.x = -1
		spriteUnlit.scale.x = -1
		direction = -1

	if Input.is_action_pressed("Jump"):
		playLeftOrRight = false

	if (abs(velocity.y) - MARGIN_OF_ERROR < 0 and justJumped):
		justJumped = false
		playLeftOrRight = false
		AnimationManager.FallAnimation()

	if Input.is_action_pressed("Sprint") and (Input.is_action_pressed("Left") or Input.is_action_pressed("Right")):
		if is_on_floor():
			velocity.x += speed * 2 * direction
	
	AnimationManager.UpdateAnimations(StateMachine, HasStaff, velocity, playLeftOrRight)
	
func _physics_process(delta):
	if (GameManager.IsGamePlaying and GameManager.IsPlayerAlive):
		get_input()
		velocity.y += gravity * delta
		velocity = move_and_slide(velocity, Vector2.UP)
		if Input.is_action_just_pressed("Jump"):
			if is_on_floor():
				AnimationManager.JumpAnimation()
				velocity.y = jump_speed
				playLeftOrRight = false
				justJumped = true
		
		if (self.position.y > 1900):
			GameManager.TeleportPlayer()
		
func PlayerDeath(position):
	if (position == null):
		print("Null Value given to PlayerDeath")
		return "null"
	self.position = position
	velocity.x = 0
	velocity.y = 0
	return self.position

func ChangeHasStaffState(state):
	HasStaff = state

func GetHasStaffState():
	return HasStaff
