extends "res://Scripts/Objects/Interactable.gd"

var WithinBlockRange
var velocity = Vector2()
var blockBody
# Called when the node enters the scene tree for the first time.
func _ready():
	WithinBlockRange = false
	blockBody = get_parent()

func _process(delta):
	velocity.x = 0.0
	velocity.y += gravity * delta
	if (WithinBlockRange):
		var direction = (blockBody.global_transform.origin - GameManager.GetPlayer().global_transform.origin).normalized()
		if ("Skinny" in blockBody.name and GameManager.GetLevelManagers()[0].allowSkinnyBlockMovement):
			velocity.x += direction.x * 200
		elif ("Small" in blockBody.name):
			velocity.x += direction.x * 300
		elif ("Large" in blockBody.name):
			velocity.x += direction.x * 100
	blockBody.move_and_slide(velocity, Vector2.UP)

func _on_Area2D_body_exited(body:Node):
	if ("Milo" in body.name):
		WithinBlockRange = false

func _on_Area2D_body_entered(body:Node):
	if ("Milo" in body.name):
		WithinBlockRange = true
