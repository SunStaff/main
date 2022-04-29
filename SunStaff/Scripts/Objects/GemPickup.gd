extends Area2D

var WithinGemPickupRange
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var shader = self.material

# Called when the node enters the scene tree for the first time.
func _ready():
	WithinGemPickupRange = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	GlowMaterial(false)
	if (WithinGemPickupRange):
		GlowMaterial(true)
		if (Input.is_action_just_pressed("Interact")):
			GemPickup()

func GemPickup():
	var color = self.name.replacen("_GemPickup", "")
	GameManager.ToggleGem(color)
	AudioManager.get_script().PlayCollectable()
	self.visible = false
	

func _on_GemPickup_body_entered(body):
	if ("Milo" in body.name):
		WithinGemPickupRange = true

func _on_GemPickup_body_exited(body):
	if ("Milo" in body.name):
		WithinGemPickupRange = false

func GlowMaterial(state):
	if (state):
		shader.set_shader_param("color", Color(1,1,1,1.0))
	else:
		shader.set_shader_param("color", Color(1,1,1,0))
