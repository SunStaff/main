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

func LeverFlipped(level, lever, turnedOn):
	match(level):
		"Tutorial":
			Tutorial(lever, turnedOn)
		"Level1":
			Level1(lever, turnedOn)
		"Level2":
			Level2(lever, turnedOn)
		"Level3":
			Level3(lever, turnedOn)

func Tutorial(lever, turnedOn):
	var name = lever.name.replacen("Lever", "")
	match(name):
		"1":
			pass
		"2":
			pass

func Level1(lever, turnedOn):
	var name = lever.name.replacen("Lever", "")
	match(name):
		"1":
			pass
		"2":
			pass

func Level2(lever, turnedOn):
	var name = lever.name.replacen("Lever", "")
	match(name):
		"1":
			pass
		"2":
			pass

func Level3(lever, turnedOn):
	var name = lever.name.replacen("Lever", "")
	match(name):
		"1":
			lever.visible = false
		"2":
			pass
