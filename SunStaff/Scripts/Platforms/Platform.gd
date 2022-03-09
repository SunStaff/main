extends KinematicBody2D


# Declare member variables here. Examples:
export (bool) var isInLight = true



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _set_rotation(angle):
	rotation = angle

func _get_rotation():
	return rotation

func _set_position(x, y):
	position = Vector2(x, y)

func _get_position():
	return position

func _get_is_in_light():
	return isInLight

func _set_is_in_light(inLight):
	isInLight = inLight

#Shows or hides platform
func _show_hide():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
