extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func PlateTouched(level, name):
	match(level):
		"Tutorial":
			Tutorial(name)
		"Level1":
			Level1(name)
		"Level2":
			Level2(name)
		"Level3":
			Level3(name)

func Tutorial(name):
	name = name.replacen("PressurePlate", "")
	match(name):
		"1":
			pass
		"2":
			pass

func Level1(name):
	name = name.replacen("PressurePlate", "")
	match(name):
		"1":
			pass
		"2":
			pass

func Level2(name):
	name = name.replacen("PressurePlate", "")
	match(name):
		"1":
			pass
		"2":
			pass

func Level3(name):
	name = name.replacen("PressurePlate", "")
	match(name):
		"1":
			pass
		"2":
			pass
