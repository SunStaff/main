extends Area2D

var WithinGemPickupRange
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	WithinGemPickupRange = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (WithinGemPickupRange):
		if (Input.is_action_just_pressed("Interact")):
			GemPickup()

func GemPickup():
	var color = self.name.replacen("_GemPickup", "")
	GameManager.ToggleGem(color)
	self.visible = false

func _on_GemPickup_body_entered(body):
	if ("Milo" in body.name):
		WithinGemPickupRange = true

func _on_GemPickup_body_exited(body):
	if ("Milo" in body.name):
		WithinGemPickupRange = false
