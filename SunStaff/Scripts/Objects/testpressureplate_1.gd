extends Area2D
signal touching

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_pressureplate1_body_entered(body):
	print(body)
	if (body.name == "Milo"):
		print("working")
		emit_signal("touching")
