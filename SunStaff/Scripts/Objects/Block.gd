extends "res://Scripts/Objects/Interactable.gd"

var WithinBlockRange
var velocity = Vector2()
export (float) var blockGravity = 9.8
var blockBody
var unlitSprite
var litSprite
var areaCollider
var bodyCollider
# Called when the node enters the scene tree for the first time.
func _ready():
	WithinBlockRange = false
	blockBody = get_parent()
	unlitSprite = blockBody.get_child(0).get_child(0)
	litSprite = blockBody.get_child(0).get_child(1)
	areaCollider = blockBody.get_child(1).get_child(0)
	bodyCollider = blockBody.get_child(2)
	if ("Skinny" in blockBody.name):
		litSprite.frame = 1
		unlitSprite.frame = 1
		areaCollider.scale = Vector2(1,1.8)
		bodyCollider.scale = Vector2(1,1.8)
		litSprite.position = Vector2(0,-12)
	elif ("Small" in blockBody.name):
		litSprite.frame = 0
		unlitSprite.frame = 0
	elif ("Large" in blockBody.name):
		litSprite.frame = 2
		unlitSprite.frame = 2
		areaCollider.scale = Vector2(1,2.6)
		bodyCollider.scale = Vector2(1,2.6)
		litSprite.position = Vector2(0,-12)

func _process(delta):
	velocity.x = 0.0
	velocity.y += blockGravity * delta
	if (WithinBlockRange):
		var direction = (blockBody.global_transform.origin - GameManager.GetPlayer().global_transform.origin).normalized()
		if ("Skinny" in blockBody.name and GameManager.GetLevelManager().allowSkinnyBlockMovement):
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
		GameManager.GetPlayer().AudioManager.PlayFrustratedMew()
