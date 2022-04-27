extends Area2D

var IsInLight = null
var activated = false
onready var staticBodyCollider = $StaticBody2D/CollisionShape2D
export var AllowPlatformSprites = false
var spriteActivated = false
var AllowCollision = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (AllowPlatformSprites and not spriteActivated and not IsInLight):
		staticBodyCollider.set_deferred("disabled", false)
		spriteActivated = true

func SetObjectLightState(state): # What to do if object only appears in dark but not light
	IsInLight = state
	if (IsInLight and not activated):
		activated = true
		if (not AllowCollision):
			staticBodyCollider.set_deferred("disabled", true)
	else:
		activated = false
		staticBodyCollider.set_deferred("disabled", false)

func FullEnablePlatform():
	if (AllowPlatformSprites):
		get_child(0).visible = true
		get_child(1).visible = true
	staticBodyCollider.set_deferred("disabled", false)
	AllowCollision = true

func FullDisablePlatform():
	get_child(0).visible = false
	get_child(1).visible = false
	staticBodyCollider.set_deferred("disabled", true)
	AllowCollision = false
