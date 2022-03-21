extends StaticBody2D


#Tells if object is within range of light objects
export var isInLight = true

#Variables to indicate if object should be present in lit/unlit world
export (bool) var showInLight = true
export (bool) var showInUnlit = true



# Called when the node enters the scene tree for the first time.
func _ready():
	_show_hide()
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
	if (isInLight):
		if(showInLight):
			#Set sprite to Lit platform
			pass
		else:
			#Hide Platform
			pass
	else:
		if(showInUnlit):
			#Set sprite to Unlit platform
			pass
		else:
			#Hide Platform
			pass

		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
