extends KinematicBody2D


onready var sprite = self.get_node("Sprite")
var faceRight = true
export (int) var speed = 300
export (int) var jump_speed = -1100
export (int) var gravity = 3000
export (float, 0, 1.0) var friction = 0.2
export (float, 0, 1.0) var acceleration = 0.25

var velocity = Vector2.ZERO

func get_input():
	if (GameManager.IsPlayerAlive):
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
	
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("Jump"):
		if is_on_floor():
			velocity.y = jump_speed
		
	
