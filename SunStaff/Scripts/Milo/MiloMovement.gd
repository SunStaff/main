extends RigidBody2D

export (int) var speed = 200

var newVelocity = Vector2()
onready var sprite = self.get_node("Sprite")
var faceRight = true

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
