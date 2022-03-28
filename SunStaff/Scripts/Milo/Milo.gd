extends KinematicBody2D

# Node Variables
var playerRootNode
var sprite
var spriteUnlit
var sprintcheck = false
var jumped

# Pedestal Variables
var WithinPedestalRange
var CurrentClosestPedestal
var minDistanceToPedestal = INF
var Pedestals = []
var PedestalName = ""
var GemObject

# SunStaff Variables
var HasStaff = true

# Movement Variables
var faceRight = true
export (int) var speed = 300
export (int) var jump_speed = -1100
export (int) var gravity = 3000
export (float, 0, 1.0) var friction = 0.5
export (float, 0, 1.0) var acceleration = 0.25
var velocity = Vector2.ZERO
var justJumped = false


func _ready():
	playerRootNode = get_parent()
	sprite = $AnimatedSprite
	spriteUnlit = $AnimatedSprite2
	spriteUnlit.visible = false
	
	WithinPedestalRange = false

func get_input():
	if (GameManager.IsPlayerAlive and GameManager.IsGamePlaying):
		# Movement
		var dir = 0
		
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
			if (!faceRight):
				print("facing right")
				sprite.scale.x *= -1
				spriteUnlit.scale.x *= -1
				faceRight = true
			if (HasStaff):
				sprite.animation = "MiloWalkStaff"
				spriteUnlit.visible = false
			else:
				spriteUnlit.visible = true
				sprite.animation = "MiloWalkStaffless"
				spriteUnlit.animation = "MiloWalkStafflessUNLIT"
		
		elif Input.is_action_just_pressed("Left"):
			if (faceRight):
				print("facing left")
				sprite.scale.x *= -1
				spriteUnlit.scale.x *= -1
				faceRight = false
			if (HasStaff):
				sprite.animation = "MiloWalkStaff"
				spriteUnlit.visible = false
			else:
				spriteUnlit.visible = true
				sprite.animation = "MiloWalkStaffless"
				spriteUnlit.animation = "MiloWalkStafflessUNLIT"

		if Input.is_action_pressed("Right"):
			if sprintcheck == true:
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
			if sprintcheck == true:
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
			if dir == 0 and velocity.y == 0:
				if (HasStaff):
				
					spriteUnlit.visible = false
					sprite.animation = "MiloIdleStaff"
				else:
				
					spriteUnlit.visible = true
					sprite.animation = "MiloIdleStaffless"
					spriteUnlit.animation = "MiloIdleStafflessUNLIT"
		if Input.is_action_pressed("sprint"):
			if (justJumped):
				if (HasStaff):
					spriteUnlit.visible = false
					sprite.animation = "MiloRunStaff"
				else:
					spriteUnlit.visible = true
					sprite.animation = "MiloRunStaffless"
					spriteUnlit.animation = "MiloRunStafflessUNLIT"
				justJumped = false
			sprintcheck = true
			print("sprint")
			if (HasStaff):
				spriteUnlit.visible = false
				sprite.animation = "MiloRunStaff"
			else:
				
				spriteUnlit.visible = true
				sprite.animation = "MiloRunStaffless"
				spriteUnlit.animation = "MiloRunStafflessUNLIT"
			
		else:
			sprintcheck = false
		if dir != 0:
			velocity.x = lerp(velocity.x, dir * speed, acceleration)
		else:
			velocity.x = lerp(velocity.x, 0, friction)

		# Gem Pedestal Placement
		if (WithinPedestalRange):
			if (Input.is_action_just_pressed("Interact")):
				print("interaction with pedestal")
				GemPlacement()
		
		# Gem Pickup
		elif (GemObject != null):
			if (Input.is_action_just_pressed("Interact")):
				print("interaction with gem")
				GemPickup()

		# If Player is Falling Passed Border
		if (self.position.y > 900):
			print("out of bounds")
			GameManager.SetPlayerAliveState(false)
	else:
		velocity = Vector2.ZERO
	
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
		
func PlayerDeath(position):
	self.position = position
	velocity.x = 0
	velocity.y = 0
	WithinPedestalRange = false

func ChangeHasStaffState(state):
	HasStaff = state

func _on_InteractRange_area_entered(area:Area2D):

	if ("GemPedestal" in area.name):
		WithinPedestalRange = true
		GetCurrentClosestPedestal()

	if ("GemPickup" in area.name):
		GemObject = area

func _on_InteractRange_area_exited(area:Area2D):

	if ("GemPedestal" in area.name):
		WithinPedestalRange = false
		GetCurrentClosestPedestal()

func GemPlacement():
	GetCurrentClosestPedestal()
	GameManager.OpenGemSelectionScreen(CurrentClosestPedestal)

func GemPickup():
	var color = GemObject.name.replacen("_GemPickup", "")
	GameManager.ToggleGem(color)
	GemObject.visible = false
	
func _on_AnimatedSprite_animation_finished(): 
	if ("MiloJumpFallStaff" in sprite.animation):
		justJumped = true

func GetCurrentClosestPedestal():
	Pedestals.clear()
	for pedestal in GameManager.GetGemPedestals():
		Pedestals.append(pedestal)
	# Get Current Closest Pedestal
	for pedestal in Pedestals:
		var distanceTo = GameManager.DistanceTo(pedestal.position, self.position)
		if (distanceTo < minDistanceToPedestal):
			minDistanceToPedestal = distanceTo
			CurrentClosestPedestal = pedestal
	minDistanceToPedestal = INF
