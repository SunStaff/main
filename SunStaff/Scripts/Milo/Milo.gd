extends KinematicBody2D

# Node Variables
var playerRootNode
var sprite
var spriteUnlit
const MARGIN_OF_ERROR = 0.008
var PlayerCamera

# Audio Variables
var AudioManager
var mewFunc = null
var allowMew = true

# SunStaff Variables
var HasStaff = true
export (bool) var TurnLightOff = false

#Animation Variables
var AnimationManager
var StateMachine
var playLeftOrRight = false

# Movement Variables
var faceRight = true
export (float) var speed = 800.0
var velocity = Vector2.ZERO
var direction
var runningSoundPlaying = false

# Jump Variables
var ctAllowJump = true
var justJumped = false
export (float) var jump_height = 750
export (float) var jump_time_to_peak = 0.4
export (float) var jump_time_to_descent = 0.3
onready var jump_velocity: float = -1 * ((2.0 * jump_height) / jump_time_to_peak)
onready var jump_gravity: float = -1 * ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak))
onready var fall_gravity: float = -1 * ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent))

func _ready():
	if (GameManager.ChangeSceneCalled):
		GameManager.GetNewInstancesOfVariables()
		GameManager.ChangeSceneCalled = false
		GameManager.SetSpawnLocation()
	
	PlayerCamera = get_child(4)
	ChangeCameraBorders()
	AudioManager = $AudioManager
	AudioManager.ChangeBetweenLitAndUnlit(HasStaff)
	
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
	#playLeftOrRight = false

	if is_on_floor():
		ctAllowJump = true

	if Input.is_action_pressed("Right"):
		velocity.x += speed
		sprite.scale.x = 1
		spriteUnlit.scale.x = 1
		direction = 1
		if (is_on_floor()):
			playLeftOrRight = true
			if (not runningSoundPlaying):
				AudioManager.PlayWalking()

	elif Input.is_action_pressed("Left"):
		velocity.x -= speed
		sprite.scale.x = -1
		spriteUnlit.scale.x = -1
		direction = -1
		if (is_on_floor()):
			playLeftOrRight = true
			if (not runningSoundPlaying):
				AudioManager.PlayWalking()
	else:
		AudioManager.StopWalking()
		AudioManager.StopRunning()
		if allowMew and (not mewFunc or not mewFunc.is_valid()):
			allowMew = false
			mewFunc = MiloMew()

	if Input.is_action_pressed("Jump"):
		playLeftOrRight = false
		velocity.x *= 1

	if (abs(velocity.y) - MARGIN_OF_ERROR < 0 and justJumped):
		justJumped = false
		playLeftOrRight = false
		AnimationManager.FallAnimation()
		yield(get_tree().create_timer(jump_time_to_descent-0.05), "timeout")
		AudioManager.PlayLanding()
		AudioManager.PlayBell()

	if Input.is_action_pressed("Sprint") and (Input.is_action_pressed("Left") or Input.is_action_pressed("Right")):
		velocity.x += speed * 2 * direction
		if (not justJumped):
			AudioManager.PlayRunning()
			runningSoundPlaying = true
	else:
		runningSoundPlaying = false
		AudioManager.StopRunning()
	
	if Input.is_action_just_released("Sprint") and (Input.is_action_pressed("Left") or Input.is_action_pressed("Right")):
		AudioManager.PlayBell()
	elif Input.is_action_just_pressed("Sprint") and (Input.is_action_pressed("Left") or Input.is_action_pressed("Right")):
		AudioManager.PlayBell()

	AnimationManager.UpdateAnimations(StateMachine, HasStaff, velocity, playLeftOrRight, speed, MARGIN_OF_ERROR)
	
func _process(delta):
	if (GameManager.IsGamePlaying and GameManager.IsPlayerAlive):
		get_input()
		if !is_on_floor():
			CoyoteTimeJump()
			velocity.y += GetGravity() * delta
		velocity = move_and_slide(velocity, Vector2.UP)
		if Input.is_action_just_pressed("Jump"):
			if (ctAllowJump):
				AnimationManager.JumpAnimation()
				velocity.y = jump_velocity
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
	AudioManager.ChangeBetweenLitAndUnlit(HasStaff)

func GetHasStaffState():
	return HasStaff

func GetGravity():
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func CoyoteTimeJump():
	yield(get_tree().create_timer(.1), "timeout")
	ctAllowJump = false

func MiloMew():
	AudioManager.PlayMew()
	yield(get_tree().create_timer(8.0), "timeout")
	allowMew = true

func ChangeCameraBorders():
	match (GameManager.GetCurrentLevel()):
		"Tutorial":
			HasStaff = false
			PlayerCamera.limit_left = -450
			PlayerCamera.limit_top = -1420
			PlayerCamera.limit_right = 10950
			PlayerCamera.limit_bottom = 2900
		"Level1":
			PlayerCamera.limit_left = -345
			PlayerCamera.limit_top = -1620
			PlayerCamera.limit_right = 21304
			PlayerCamera.limit_bottom = 1620
		"Level2":
			PlayerCamera.limit_left = -1380
			PlayerCamera.limit_top = -2850
			PlayerCamera.limit_right = 13000
			PlayerCamera.limit_bottom = 3600
		"Level3":
			PlayerCamera.limit_left = -220
			PlayerCamera.limit_top = -2800
			PlayerCamera.limit_right = 9880
			PlayerCamera.limit_bottom = 1480
