extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Levers = []
var Doors = []
var door1
var door2
var door3
var door4

# Distance Variables:
var minDistanceToLever = INF
var CurrentClosestLever = null

# Called when the node enters the scene tree for the first time.
func _ready():
	Levers = GameManager.GetLevers()
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
			return "Tutorial"
		"Level1":
			Level1(lever, turnedOn)
			return "Level1"
		"Level2":
			Level2(lever, turnedOn)
			return "Level2"
		"Level3":
			Level3(lever, turnedOn)
			return "Level3"
		_:
			print("Not Valid Level Name for LeverFlipped()")
			return "Not Valid Level Name for LeverFlipped()"

func Tutorial(lever, _turnedOn):
	var name = lever.name.replacen("Lever", "")
	match(name):
		"1":
			pass
		"2":
			pass

func Level1(lever, _turnedOn):
	var name = lever.name.replacen("Lever", "")
	match(name):
		"1":
			pass
		"2":
			pass

func Level2(lever, _turnedOn):
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
		#Lever 1 of Door Puzzle [Lever Down y = 420, lever up y = 644S]
		#Doors for puzzle are offset by 1 -- Door2 is first puzzle door
		"2":
			if(turnedOn):
				door1.position.y = 644
				door2.position.y = 644
				door4.position.y = 420			
			elif(!turnedOn):
				door1.position.y = 420
				door2.position.y = 420
			pass
		#Lever 2 of Door Puzzle
		"3":
			if(turnedOn):
				door2.position.y = 644
				door4.position.y = 644			
			elif(!turnedOn):
				door2.position.y = 420
				door4.position.y = 420
			pass
		#Lever 3 of Door Puzzle
		"4":
			if(turnedOn):
				door1.position.y = 644
				door3.position.y = 420			
			elif(!turnedOn):
				door1.position.y = 644
			pass
		#Lever 4 of Door Puzzle
		"5":
			if(turnedOn):
				door2.position.y = 644
				door3.position.y = 644
				door4.position.y = 420			
			elif(!turnedOn):
				door3.position.y = 420
				door4.position.y = 420
			pass

func GetCurrentClosestLever(levers, player):
	Levers.clear()
	CurrentClosestLever = null
	for lever in levers:
		Levers.append(lever)
	# Get Current Closest Lever
	for lever in Levers:
		var distanceTo =  GameManager.DistanceTo(player.position, lever.position)
		if (distanceTo < minDistanceToLever):
			minDistanceToLever = distanceTo
			CurrentClosestLever = lever
	minDistanceToLever = INF
	return CurrentClosestLever
