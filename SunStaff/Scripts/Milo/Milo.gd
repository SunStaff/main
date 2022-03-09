extends KinematicBody2D

# Node Variables
var playerRootNode
var sprite

# Sun Staff Variables
var SunStaff
var LightCircle
var WithinAltarRange
var StaffAltar

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
	LightCircle = get_node("/root/Node/Milo/Sprite/SunStaff/LightCircle")
	StaffAltar = get_node("/root/Node/StaffAltar/Sprite/StaffInAltar") # CHANGE AT LATER POINT --> NEEDS TO BE FROM CHECKPOINTS/GAMEMANAGER
	WithinAltarRange = false

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
				SunStaff.visible = !SunStaff.visible
				StaffAltar.visible = !StaffAltar.visible
				if (StaffAltar.visible):
					LightCircle.monitoring = false
				else:
					LightCircle.monitoring = true

				# SunStaff.set_deferred("visible", !SunStaff.visible)
				# StaffAltar.set_deferred("visible", !StaffAltar.visible)
				# if (StaffAltar.call_deferred("visible")):
				# 	LightCircle.set_deferred("monitoring", false)
				# else:
				# 	LightCircle.set_deferred("monitoring", true)
	
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("Jump"):
		if is_on_floor():
			velocity.y = jump_speed
		
func PlayerDeath(position):
	self.position = position
	SunStaff.set_deferred("visible", true)
	StaffAltar.set_deferred("visible", false)
	LightCircle.set_deferred("monitoring", true)
	WithinAltarRange = false
	
func _on_LightCircle_PlayerInAltarRange(state):
	WithinAltarRange = state
