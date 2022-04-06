extends KinematicBody2D

# Node Variables
var playerRootNode
var sprite
var spriteUnlit
var sprintCheck = false
var jumped
var direction
var facingright

# SunStaff Variables
var HasStaff = true
export (bool) var TurnLightOff = false

#Animation Variables
var AnimationManager

# Movement Variables
var faceRight = true
export (int) var speed = 300
export (int) var jump_speed = -1100
export (int) var gravity = 3000
export (float, 0, 1.0) var friction = 1
export (float, 0, 1.0) var acceleration = 0.25
var velocity = Vector2.ZERO
var justJumped = false

func _ready():
	if (TurnLightOff):
		GameManager.GetSunStaff().visible = false
	playerRootNode = get_parent()
	sprite = $AnimatedSprite
	spriteUnlit = $AnimatedSprite2
	spriteUnlit.visible = false
	AnimationManager = load("res://Scripts/Milo/MiloAnimationManager.gd")

func get_input():
	if (GameManager.IsPlayerAlive and GameManager.IsGamePlaying):
		# Movement
		
		var dir = 0
		direction = dir
		if velocity.x > 0:
			# print("going right")
			facingright = true
		elif velocity.x < 0:
			# print("going  left")
			facingright = false
		else:
			# print("idle")
			facingright = false
		
		if !is_on_floor():
			# print("not on ground")
			jumped = true
		else:
			jumped = false
		
		if (Input.is_action_pressed("sprint")):
			sprintCheck = true
		else:
			sprintCheck = false

		if Input.is_action_just_pressed("Jump"): 
			if is_on_floor():
				velocity.y = jump_speed
				if (HasStaff):
					sprite.animation = "MiloJumpFallStaff"
					spriteUnlit.visible = false
				else:
					spriteUnlit.visible = true
					sprite.animation = "MiloJumpFallStaffless"
					spriteUnlit.animation = "MiloJumpFallUNLIT"		
			
		elif Input.is_action_just_pressed("Right"):
			if (HasStaff):
				sprite.animation = "MiloWalkStaff"
				spriteUnlit.visible = false
			elif(!HasStaff):
				spriteUnlit.visible = true
				sprite.animation = "MiloWalkStaffless"
				spriteUnlit.animation = "MiloWalkStafflessUNLIT"
		
		elif Input.is_action_just_pressed("Left"):
			if (HasStaff):
				sprite.animation = "MiloWalkStaff"
				spriteUnlit.visible = false
			elif(!HasStaff):
				spriteUnlit.visible = true
				sprite.animation = "MiloWalkStaffless"
				spriteUnlit.animation = "MiloWalkStafflessUNLIT"

		if sprintCheck:
			if (HasStaff and jumped == false):
				spriteUnlit.visible = false
				sprite.animation = "MiloRunStaff"
			
			elif(!HasStaff and jumped == false):
				spriteUnlit.visible = true
				sprite.animation = "MiloRunStaffless"
				spriteUnlit.animation = "MiloRunStafflessUNLIT"

		if Input.is_action_pressed("Right"):
			if (!faceRight and facingright):
				# print("facing right")
				sprite.scale.x *= -1
				spriteUnlit.scale.x *= -1
				faceRight = true
			if sprintCheck == true:
				dir += 2
			else:
				dir += 1
				
			if (justJumped):
				if (HasStaff):
					spriteUnlit.visible = false
					sprite.animation = "MiloWalkStaff"
				else:
					spriteUnlit.visible = true
					sprite.animation = "MiloWalkStaffless"
					spriteUnlit.animation = "MiloWalkStafflessUNLIT"
				justJumped = false
		
		elif Input.is_action_pressed("Left"):
			if (faceRight):
				# print("facing left")
				sprite.scale.x *= -1
				spriteUnlit.scale.x *= -1
				faceRight = false
			if sprintCheck == true:
				dir -= 2
			else:
				dir -= 1
			if (justJumped):
				if (HasStaff):
					spriteUnlit.visible = false
					sprite.animation = "MiloWalkStaff"
				else:
					spriteUnlit.visible = true
					sprite.animation = "MiloWalkStaffless"
					spriteUnlit.animation = "MiloWalkStafflessUNLIT"
				justJumped = false
			
		else:
			sprintCheck = false
			if dir == 0 and velocity.y == 0:
				if (HasStaff and jumped == false):
				
					spriteUnlit.visible = false
					sprite.animation = "MiloIdleStaff"
				elif(!HasStaff and jumped == false):
				
					spriteUnlit.visible = true
					sprite.animation = "MiloIdleStaffless"
					spriteUnlit.animation = "MiloIdleStafflessUNLIT"
		
		if dir != 0:
			velocity.x = lerp(velocity.x, dir * speed, acceleration)
		else:
			velocity.x = lerp(velocity.x, 0, friction)

		# If Player is Falling Passed Border
		if (self.position.y > 1500):
			print("out of bounds")
			GameManager.SetPlayerAliveState(false)
	else:
		velocity = Vector2.ZERO
	
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
		
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
	
func _on_AnimatedSprite_animation_finished(): 
	if ("MiloJumpFallStaff" in sprite.animation):
		justJumped = true
