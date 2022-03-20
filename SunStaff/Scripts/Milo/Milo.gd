extends KinematicBody2D

# Node Variables
var playerRootNode
var sprite

# Sun Staff Variables
var SunStaff
var LightCircle
var WithinAltarRange
var StaffAltars = []
var StaffVisibility
var AltarStaffVisibility
var currentClosestAltar
var minDistanceToAltar = INF

# Movement Variables
var faceRight = true
export (int) var speed = 300
export (int) var jump_speed = -1100
export (int) var gravity = 3000
export (float, 0, 1.0) var friction = 0.2
export (float, 0, 1.0) var acceleration = 0.25
var velocity = Vector2.ZERO

func _ready():
	playerRootNode = get_parent()
	sprite = self.get_node("Sprite")
	SunStaff = self.get_child(0).get_child(0) # Gets Sun Staff 
	LightCircle = get_child(0).get_child(0).get_child(1)
	
	WithinAltarRange = false
	StaffVisibility = true
	AltarStaffVisibility = false
	var staffAltarObjects = GameManager.GetSunStaffAltars()
	for altar in staffAltarObjects:
		StaffAltars.append(altar.get_child(1).get_child(0))

func get_input():
	if (GameManager.IsPlayerAlive):
		# Movement
		var dir = 0
		if Input.is_action_just_pressed("Right"):
			if (!faceRight):
				sprite.scale.x *= -1
				faceRight = true
		if Input.is_action_just_pressed("Left"):
			if (faceRight):
				sprite.scale.x *= -1
				faceRight = false
		if Input.is_action_pressed("Right"):
			dir += 1
		if Input.is_action_pressed("Left"):
			dir -= 1
		if dir != 0:
			velocity.x = lerp(velocity.x, dir * speed, acceleration)
		else:
			velocity.x = lerp(velocity.x, 0, friction)

		# Sun Staff Placement
		if (WithinAltarRange):
			if (Input.is_action_just_pressed("Interact")):
				if (SunStaff.visible): # If Milo is holding staff
					SunStaff.visible = false
					currentClosestAltar.visible = true
				else: # If the altar has the Staff
					SunStaff.visible = true
					currentClosestAltar.visible = false
				if (currentClosestAltar.visible): # If the altar has the Staff, turn off LightCircle monitoring
					LightCircle.monitoring = false
				else:
					LightCircle.monitoring = true

		# If Player is Falling Passed Border
		if (self.position.y > 900):
			GameManager.SetPlayerAliveState(false)
	
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("Jump"):
		if is_on_floor():
			velocity.y = jump_speed
	
	# Get Current Closest Altar
	for altar in StaffAltars:
		var distanceTo = sqrt(pow((altar.position.x - self.position.x),2) + pow((altar.position.y - self.position.y),2))
		if (distanceTo < minDistanceToAltar):
			minDistanceToAltar = distanceTo
			currentClosestAltar = altar
		
func PlayerDeath(position):
	self.position = position
	SunStaff.set_deferred("visible", true)
	currentClosestAltar.set_deferred("visible", false)
	LightCircle.set_deferred("monitoring", true)
	WithinAltarRange = false

func _on_InteractRange_area_exited(area:Area2D):
	if ("StaffAltar" in area.name):
		WithinAltarRange = false

func _on_InteractRange_area_entered(area:Area2D):
	if ("StaffAltar" in area.name):
		WithinAltarRange = true
