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
		#Lever 1 of Door Puzzle [Lever Down y = 252, lever up y = 110S]
		#Doors for puzzle are offset by 1 -- Door2 is first puzzle door
		"2":
			var door1 = get_parent().get_node("Door2")
			var door2 = get_parent().get_node("Door3")
			var door4 = get_parent().get_node("Door5")
			if(turnedOn):
				door1.position.y = 110
				door2.position.y = 110
				door4.position.y = 252			
			elif(!turnedOn):
				door1.position.y = 252
				door2.position.y = 252
			pass
		#Lever 2 of Door Puzzle
		"3":
			var door2 = get_parent().get_node("Door3")
			var door4 = get_parent().get_node("Door5")
			if(turnedOn):
				door2.position.y = 110
				door4.position.y = 110			
			elif(!turnedOn):
				door2.position.y = 252
				door4.position.y = 252
			pass
		#Lever 3 of Door Puzzle
		"4":
			var door1 = get_parent().get_node("Door2")
			var door3 = get_parent().get_node("Door4")
			if(turnedOn):
				door1.position.y = 110
				door3.position.y = 252			
			elif(!turnedOn):
				door1.position.y = 110
			pass
		#Lever 4 of Door Puzzle
		"5":
			var door2 = get_parent().get_node("Door3")
			var door3 = get_parent().get_node("Door4")
			var door4 = get_parent().get_node("Door5")
			if(turnedOn):
				door2.position.y = 110
				door3.position.y = 110
				door4.position.y = 252			
			elif(!turnedOn):
				door3.position.y = 252
				door4.position.y = 252
			pass