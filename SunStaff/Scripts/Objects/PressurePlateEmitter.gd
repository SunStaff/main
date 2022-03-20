extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var PressurePlateManager

# Called when the node enters the scene tree for the first time.
func _ready():
	PressurePlateManager = get_node("/root/PressurePlateManager")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PressurePlate_body_entered(body):
	if ("Milo" in body.name):
		PressurePlateManager.PlateTouched(GameManager.GetCurrentLevel(), self.name)
		GameManager.SetLastLivingPos(self.position)
