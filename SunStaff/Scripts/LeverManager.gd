extends Node

var Doors = []
var door1
var door2
var door3
var door4

#Similar concept to Doors, but platforms for a level 1 puzzle
var Platforms = []
var platform1
var platform2
var platform3

#num * -INCREMENT determines puzzle platform's y-pos
var num1 = 0
var num2 = 0
var num3 = 0
#increment at which platforms move when num is increased by 1.
const INCREMENT = 200
#Lowest possible y-pos for puzzle platforms
const PLATFORM_OFFSET = -269

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
	if (leverNameValid):
		leverNameValid = false
		if(leverFlippedCount == 1):
			door1.OpenDoor()
		else:
			door1.CloseDoor()
		if(leverFlippedCount == 2):
			door2.OpenDoor()
		else:
			door2.CloseDoor()
	
		

func Level1(lever, turnedOn):
	var name = lever.name.replacen("Lever", "")
	
	var POS1 = 2841
	var POS2 = 7425
	var POS3 = 12768
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
			if (turnedOn):
				GameManager.GetLevelManagers()[0].ChangeAltarPos(POS3, true)
				GameManager.GetLevelManagers()[0].SetAltarCheckPoint(3)
			else:
				GameManager.GetLevelManagers()[0].ChangeAltarPos(POS2, false)
				GameManager.GetLevelManagers()[0].SetAltarCheckPoint(2)
		#First lever to flick in level, releases bridge
		"6":
			GameManager.GetLevelManagers()[0].ReleaseDrawBridge()
		#Moves altar to second altar position
		"7":
			if (turnedOn):
				GameManager.GetLevelManagers()[0].ChangeAltarPos(POS2, true)
				GameManager.GetLevelManagers()[0].SetAltarCheckPoint(2)
			else:
				GameManager.GetLevelManagers()[0].ChangeAltarPos(POS1, false)
				GameManager.GetLevelManagers()[0].SetAltarCheckPoint(1)

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
				door1.CloseDoor()
				door2.CloseDoor()
				door4.OpenDoor()		
			elif(!turnedOn):
				door1.OpenDoor()
				door2.OpenDoor()
			pass
		#Lever 2 of Door Puzzle
		"3":
			if(turnedOn):
				door2.CloseDoor()
				door4.CloseDoor()			
			elif(!turnedOn):
				door2.OpenDoor()
				door4.OpenDoor()
			pass
		#Lever 3 of Door Puzzle
		"4":
			if(turnedOn):
				door1.CloseDoor()
				door3.OpenDoor()
			elif(!turnedOn):
				door1.CloseDoor()
			pass
		#Lever 4 of Door Puzzle
		"5":
			if(turnedOn):
				door2.CloseDoor()
				door3.CloseDoor()
				door4.OpenDoor()		
			elif(!turnedOn):
				door3.OpenDoor()
				door4.OpenDoor()
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
	#Level 1 has platforms interacting with levers
	if(get_tree().get_current_scene().get_name() == "Level1"):
		Platforms.clear()
		Platforms = get_tree().get_nodes_in_group("Platform")
		platform1 = Platforms[0]
		platform2 = Platforms[1]
		platform3 = Platforms[2]
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
