extends RigidBody2D

export (int) var speed = 200

var newVelocity = Vector2()
onready var sprite = self.get_node("Sprite")
var faceRight = true
<<<<<<< Updated upstream
=======
export (int) var speed = 300
export (int) var jump_speed = -1100
export (int) var gravity = 3000
export (float, 0, 1.0) var friction = 0.2
export (float, 0, 1.0) var acceleration = 0.25
>>>>>>> Stashed changes

func _ready():
	self.mode = MODE_CHARACTER

func get_input():
	var velocity = Vector2()
	if Input.is_action_just_pressed("Right"):
		if (!faceRight):
			sprite.scale.x *= -1
			faceRight = true
	if Input.is_action_just_pressed("Left"):
		if (faceRight):
			sprite.scale.x *= -1
			faceRight = false
	if Input.is_action_just_pressed("Jump"):
		velocity.y -= 1

	if Input.is_action_pressed("Right"):
		velocity.x += 1
	if Input.is_action_pressed("Left"):
		velocity.x -= 1
	if Input.is_action_pressed("Jump"):
		velocity.y -= 1
	velocity.y += 0.0
	newVelocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	self.linear_velocity = newVelocity
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("Jump"):
		if is_on_floor():
			velocity.y = jump_speed
		
	

