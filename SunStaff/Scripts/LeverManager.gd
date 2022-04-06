extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Doors = []
var door1
var door2
var door3
var door4
# Called when the node enters the scene tree for the first time.
func _ready():
	#Added if-statement, so the doors are only obtained for level 3
	if(get_tree().get_current_scene().get_name() == "Level3"):
		Doors = get_tree().get_nodes_in_group("Door")
		door1 = Doors[1]
		door2 = Doors[2]
		door3 = Doors[3]
		door4 = Doors[4]


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
		#Lever 1 of Door Puzzle [Lever Down y = 238, lever up y = 110]
		#Doors for puzzle are offset by 1 -- Door2 is first puzzle door
		"2":
			if(turnedOn):
				door1.position.y = 110
				door2.position.y = 110
				door4.position.y = 238			
			elif(!turnedOn):
				door1.position.y = 238
				door2.position.y = 238
			
		#Lever 2 of Door Puzzle
		"3":
			if(turnedOn):
				door2.position.y = 110
				door4.position.y = 110			
			elif(!turnedOn):
				door2.position.y = 238
				door4.position.y = 238
			
		#Lever 3 of Door Puzzle
		"4":
			if(turnedOn):
				door1.position.y = 110
				door3.position.y = 238			
			elif(!turnedOn):
				door1.position.y = 110
			
		#Lever 4 of Door Puzzle
		"5":
			if(turnedOn):
				door2.position.y = 238
				door3.position.y = 110
				door4.position.y = 110			
			elif(!turnedOn):
				door3.position.y = 238
				door4.position.y = 238
			
