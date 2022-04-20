extends Node

export var IsPlayerAlive = true
export var IsGamePlaying = true
export var CurrentLevel = ""
export var LastLivingPos = Vector2()
export var GemsCollected = {"Green": false, "Blue": false, "Red": false, "Cyan": false, "Magenta": false }
var activated = false
var Player
var GemSelectionScreen
var SceneTransition
var ChangeSceneCalled = false
var LevelManagers = []
var AutoTester

# Called when the node enters the scene tree for the first time.
func _ready():
	SceneTransition = preload("res://Scenes/Menus/SceneTransitionRect.tscn").instance()
	self.add_child(SceneTransition)
	SceneTransition = SceneTransition.get_child(0)
	SetCurrentLevel(get_tree().get_current_scene().get_name())

	if (not ("MainMenu" in get_tree().get_current_scene().get_name())):
		AutoTester = preload("res://Scripts/Auto_Tester.gd").new()
		if (!AutoTester.Execute(get_node("/root/LeverManager"))):
			IsGamePlaying = false
			print("Testing Failed!! Please check tests!!")
		Player = GetPlayer()
		LevelManagers = GetLevelManagers()
		GemsCollected = {"Green": true, "Blue": true, "Red": true, "Cyan": true, "Magenta": true }
		
		SetSpawnLocation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (!IsPlayerAlive && !activated):
		activated = true
		TeleportPlayer()

func GetPlayer():
	return get_tree().get_nodes_in_group("Player")[0]

func GetPlayerAliveState():
	return IsPlayerAlive

func SetPlayerAliveState(playerState):
	IsPlayerAlive = playerState
	IsGamePlaying = playerState

func SetCurrentLevel(newLevel):
	CurrentLevel = newLevel

func GetCurrentLevel():
	return CurrentLevel

func SetLastLivingPos(position): # Pressure Plate executes with its' position so the player can respawn there
	LastLivingPos = position

func GetSunStaffAltars():
	return get_tree().get_nodes_in_group("StaffAltar")

func GetSunStaff():
	return GetPlayer().get_child(1).get_child(0)

func GetGemPedestals():
	return get_tree().get_nodes_in_group("GemPedestal")

func GetLevers():
	return get_tree().get_nodes_in_group("Lever")

func GetGemStates():
	return GemsCollected

func GetLevelManagers():
	return get_tree().get_nodes_in_group("LevelManager")

func TeleportPlayer():
	Player.PlayerDeath(LastLivingPos) 
	GameManager.SetPlayerAliveState(true)
	GameManager.activated = false

func ToggleGem(color):
	match color:
		"Green":
			if (GemsCollected.get("Green")):
				GemsCollected.Green = false
				return ["Green", false]
			else:
				GemsCollected.Green = true
				return ["Green", true]
		"Red":
			if (GemsCollected.get("Red")):
				GemsCollected.Red = false
				return ["Red", false]
			else:
				GemsCollected.Red = true
				return ["Red", true]
		"Blue":
			if (GemsCollected.get("Blue")):
				GemsCollected.Blue = false
				return ["Blue", false]
			else:
				GemsCollected.Blue = true
				return ["Blue", true]
		"Cyan":
			if (GemsCollected.get("Cyan")):
				GemsCollected.Cyan = false
				return ["Cyan", false]
			else:
				GemsCollected.Cyan = true
				return ["Cyan", true]
		"Magenta":
			if (GemsCollected.get("Magenta")):
				GemsCollected.Magenta = false
				return ["Magenta", false]
			else:
				GemsCollected.Magenta = true
				return ["Magenta", true]
		_:
			print("Not Valid Gem Color for ToggleGem()")
			return ["Not Valid Gem Color for ToggleGem()", null]

func CheckForLevelSpecificActions(from, information, optionalNode):
	LevelManagers.clear()
	LevelManagers = GetLevelManagers()
	match CurrentLevel:
		"Tutorial":
			if ("Altar" in from):
				if ("_MoveDoor" in optionalNode.name):
					LevelManagers[0].Tutorial_MoveDoor_DueTo_StaffAltar(information)
		"Level1":
			pass
		"Level2":
			pass
		"Level3":
			if ("Altar" in from):
				if ("_MoveDoor" in optionalNode.name):
					LevelManagers[0].Level3_MoveDoor_DueTo_StaffAltar(information)
				elif ("_GemPuzzle" in optionalNode.name):
					LevelManagers[0].ChangeAltarBeamColors(information, optionalNode)

func DistanceTo(a,b):
	if (a == null or b == null):
		return -1
	else:
		var x = b.x - a.x
		var y = b.y - a.y
		return sqrt(pow(x,2) + pow(y,2))

func SetSpawnLocation():
	match CurrentLevel:
		"Tutorial":
			LastLivingPos = Vector2(0, -400)
		"Level1":
			LastLivingPos = Vector2(-60, -325)
		"Level2":
			LastLivingPos = Vector2(500,-250)
		"Level3":
			LastLivingPos = Vector2(0,0)

	TeleportPlayer()

func ChangeScene():
	IsGamePlaying = false
	match CurrentLevel:
		"MainMenu":
			SceneTransition.transition_to("res://Scenes/Tutorial.tscn") # TODO: CHANGE ONCE TUTORIAL AND LEVEL 1 ARE COMPLETE
			SetCurrentLevel("Tutorial")
		"Tutorial":
			SceneTransition.transition_to("res://Scenes/Level2.tscn")
			SetCurrentLevel("Level2")
		"Level1":
			SceneTransition.transition_to("res://Scenes/Level2.tscn")
			SetCurrentLevel("Level2")
		"Level2":
			SceneTransition.transition_to("res://Scenes/Level3.tscn")
			SetCurrentLevel("Level3")
		"Level3":
			SceneTransition.transition_to("res://Scenes/Menus/MainMenu.tscn")
			SetCurrentLevel("MainMenu")
	ClearVariables()
	ChangeSceneCalled = true
	print("Change Scene Called")

func ClearVariables():
	Player = null
	LevelManagers.clear()
	activated = null

func GetNewInstancesOfVariables():
	Player = GetPlayer()
	LevelManagers = GetLevelManagers()
	activated = false
	SetSpawnLocation()
	IsGamePlaying = true
	if (not ("MainMenu" in get_tree().get_current_scene().get_name())):
		AutoTester = preload("res://Scripts/Auto_Tester.gd").new()
		if (!AutoTester.Execute(get_node("/root/LeverManager"))):
			IsGamePlaying = false
			print("Testing Failed!! Please check tests!!")
