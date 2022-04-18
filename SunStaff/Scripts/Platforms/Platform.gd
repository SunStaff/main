extends StaticBody2D


#Tells if object is within range of light objects
export var IsInLight = true

#Variables to indicate if object should be present in lit/unlit world
export (bool) var showInLight = true
export (bool) var showInUnlit = true

var activated = false

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
	return IsInLight

func _set_is_in_light(inLight):
	IsInLight = inLight

#Shows or hides platform
func _show_hide():
	pass
	# if (IsInLight):
	# 	if(showInLight and !activatedLight):
	# 		activatedLight = true
	# 		#Set sprite to Lit platform
	# 		get_child(0).visible = false
	# 		get_child(1).visible = true
	# 		get_child(2).set_deferred("disabled", false)
	# 	else:
	# 		activatedLight = false
	# 		#Hide Platform
	# 		get_child(0).visible = false
	# 		get_child(1).visible = false
	# 		get_child(2).set_deferred("disabled", true)
	# else:
	# 	if(showInUnlit and !activatedUnlit):
	# 		#Set sprite to Unlit platform
	# 		activatedUnlit = true
	# 		get_child(0).visible = true
	# 		get_child(1).visible = false
	# 		get_child(2).set_deferred("disabled", false)
	# 	else:
	# 		#Hide Platform
	# 		activatedUnlit = false
	# 		get_child(0).visible = false
	# 		get_child(1).visible = false
	# 		get_child(2).set_deferred("disabled", true)

func SetObjectLightState(state): # What to do if object only appears in dark but not light
	IsInLight = state
	if (IsInLight && !activated):
		activated = true
		get_child(0).visible = false
		self.get_child(2).set_deferred("disabled", true)
	else:
		get_child(0).visible = true
		activated = false
		self.get_child(2).set_deferred("disabled", false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
