extends Node

var Doors = []
var door1
var door2
var door3
var door4

# Testing Variables
var leverNameValid = false

# Distance Variables:
var minDistanceToLever = INF
var CurrentClosestLever = null
#lever flipped count
var leverFlippedCount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func LeverFlipped(level, lever, turnedOn):
	GetDoors()
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

func Tutorial(lever, turnedOn):
	var name = lever.name.replacen("Lever", "")
	match(name):
		"1":
			leverNameValid = true
			if (turnedOn):
				leverFlippedCount += 1
				print("LeverFlippedCount up 1")
			elif(!turnedOn):
				leverFlippedCount -= 1
				print("LeverFlippedCount down 1")
		"2":
			leverNameValid = true
			if (turnedOn):
				leverFlippedCount += 1
				print("LeverFlippedCount up 1")
			elif(!turnedOn):
				leverFlippedCount -= 1
				print("LeverFlippedCount down 1")
	print("LeverFlippedCount: ", leverFlippedCount)
	if(leverFlippedCount == 1):
			door1.position.y = 750
	else:
			door1.position.y = 250
	if(leverFlippedCount == 2):
			door2.position.y = 780
	
		

func Level1(lever, turnedOn):
	var name = lever.name.replacen("Lever", "")
	match(name):
		#For Levers 1-3, whenever the lever is flicked the platform elevates by x units
		#When each num is capped at 10, and will "reset" the platform at a lower elevation
		#Could be frustrating to complete depending on the player (maybe needs to be reworked due to screensize)
		
		#First lever for ending lever puzzle
		"1":
			GameManager.GetLevelManagers()[0].FlippedPuzzleLever(1)
		#Second lever for ending lever puzzle
		"2":
			GameManager.GetLevelManagers()[0].FlippedPuzzleLever(2)
		#Third lever for ending lever puzzle
		"3":
			GameManager.GetLevelManagers()[0].FlippedPuzzleLever(3)
		#Drops block to get to 2 levers
		"4":
			GameManager.GetLevelManagers()[0].MoveBlock()
		#Moves altar to third altar position
		"5":
			GameManager.GetLevelManagers()[0].ChangeAltarPos()
			GameManager.GetLevelManagers()[0].SetAltarCheckPoint(3)
		#First lever to flick in level, releases bridge
		"6":
			GameManager.GetLevelManagers()[0].ReleaseDrawBridge()
		#Moves altar to second altar position
		"7":
			GameManager.GetLevelManagers()[0].ChangeAltarPos()
			GameManager.GetLevelManagers()[0].SetAltarCheckPoint(2)

func Level2(lever, turnedOn):
	var name = lever.name.replacen("Lever", "")
	match(name):
		"1":
			leverNameValid = true
			if (turnedOn):
				leverFlippedCount += 1
				print("LeverFlippedCount up 1")
			elif(!turnedOn):
				leverFlippedCount -= 1
				print("LeverFlippedCount down 1")
		"2":
			leverNameValid = true
			if(turnedOn):
				leverFlippedCount += 1
			elif(!turnedOn):
				leverFlippedCount -= 1
		"3":
			leverNameValid = true
			if(turnedOn):
				leverFlippedCount += 1
			elif(!turnedOn):
				leverFlippedCount -= 1
		"4":
			GameManager.GetLevelManagers()[0].Level2_Ravine_FirstLever(turnedOn)
		"5":
			GameManager.GetLevelManagers()[0].Level2_Ravine_SecondLever(turnedOn)
	print("LeverFlippedCount: ", leverFlippedCount)
	if (leverNameValid):
		leverNameValid = false
		if(leverFlippedCount >= 3):
			door1.OpenDoor()
		elif(leverFlippedCount < 3):
			door1.CloseDoor()


func Level3(lever, turnedOn):
	var name = lever.name.replacen("Lever", "")
	match(name):
		"1":
			lever.visible = false
		#Lever 1 of Door Puzzle [Lever Down y = -200, lever up y = 430S]
		#Doors for puzzle are offset by 1 -- Door2 is first puzzle door
		"2":
			if(turnedOn):
				door1.position.y = 430
				door2.position.y = 430
				door4.position.y = -200			
			elif(!turnedOn):
				door1.position.y = -200
				door2.position.y = -200
			pass
		#Lever 2 of Door Puzzle
		"3":
			if(turnedOn):
				door2.position.y = 430
				door4.position.y = 430			
			elif(!turnedOn):
				door2.position.y = -200
				door4.position.y = -200
			pass
		#Lever 3 of Door Puzzle
		"4":
			if(turnedOn):
				door1.position.y = 430
				door3.position.y = -200			
			elif(!turnedOn):
				door1.position.y = 430
			pass
		#Lever 4 of Door Puzzle
		"5":
			if(turnedOn):
				door2.position.y = 430
				door3.position.y = 430
				door4.position.y = -200			
			elif(!turnedOn):
				door3.position.y = -200
				door4.position.y = -200
			pass

func GetCurrentClosestLever(levers, player):
	var childOfRoot = true
	var test = false
	for lever in levers:
		if (lever.get_parent() == null):
			test = true

	if (!test):
		if ("Level" in levers[0].get_parent().name or "Tutorial" in levers[0].get_parent().name):
			childOfRoot = true
		else:
			childOfRoot = false
	CurrentClosestLever = null
	# Get Current Closest Lever
	for lever in levers:
		var distanceTo = 0
		if (childOfRoot):
			distanceTo = GameManager.DistanceTo(player.position, lever.position)
		else:
			distanceTo = GameManager.DistanceTo(player.position, lever.global_position)
		if (distanceTo < minDistanceToLever):
			minDistanceToLever = distanceTo
			CurrentClosestLever = lever
	minDistanceToLever = INF
	return CurrentClosestLever

func GetDoors():
	Doors.clear()
	if(get_tree().get_current_scene().get_name() == "Level2"):
		Doors = get_tree().get_nodes_in_group("Door")
		door1 = Doors[0]
	#Added if-statement, so the doors are only obtained for level 3
	if(get_tree().get_current_scene().get_name() == "Level3"):
		Doors = get_tree().get_nodes_in_group("Door")
		door1 = Doors[1]
		door2 = Doors[2]
		door3 = Doors[3]
		door4 = Doors[4]
	if(get_tree().get_current_scene().get_name() == "Tutorial"):
		Doors = get_tree().get_nodes_in_group("Door")
		door1 = Doors[0]
		door2 = Doors[1]
