extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var MIN_VALUE = 0.2
var MAX_VALUE = 2.25
var CHANGING_VALUE = 0.005
var light2D
var currentValue = 0.0
var increase = true
var decrease = false
# Called when the node enters the scene tree for the first time.
func _ready():
	light2D = get_node("Control/Container/Light2D")
	currentValue = light2D.texture_scale
	GameManager.ClearVariables()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	LightingEffect()

func _on_PlayButton_pressed():
	GameManager.ChangeScene()

# CURRENTLY DISABLED IN INSPECTOR
func _on_QuitButton_pressed():
	get_tree().quit()

func LightingEffect():
	currentValue = light2D.texture_scale
	# If the current value is less than 0.2, start increasing to 4
	# If the current value is greater than 4, start decreasing to 0.2
	# else increase to 4
	if (currentValue <= MIN_VALUE):
		yield(get_tree().create_timer(2.5), "timeout")
		increase = true
		decrease = false
		light2D.set_deferred("texture_scale", currentValue + CHANGING_VALUE)
		
	elif (currentValue >= MAX_VALUE):
		yield(get_tree().create_timer(2.5), "timeout")
		decrease = true
		increase = false
		light2D.set_deferred("texture_scale", currentValue - CHANGING_VALUE)
	else:
		if (increase):
			light2D.set_deferred("texture_scale", currentValue + CHANGING_VALUE)
		elif (decrease):
			light2D.set_deferred("texture_scale", currentValue - CHANGING_VALUE)
