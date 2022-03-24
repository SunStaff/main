extends Node

export var IsPlayerAlive = true
export var IsGamePlaying = true
export var CurrentLevel = ""
export var LastLivingPos = Vector2()
export var SunStaffAltarObjects = []
export var GemsCollected = {"Green": false, "Blue": false, "Red": false, "Cyan": false, "Magenta": false }
var placedGem = ""
var activated
var Player
var GemSelectionScreen
var LevelManagers = []
var pedestal


# Called when the node enters the scene tree for the first time.
func _ready():
	activated = false
	LastLivingPos = Vector2(0,55)
	Player = get_tree().get_nodes_in_group("Player")[0]
	GemSelectionScreen = get_tree().get_nodes_in_group("GemSelectionScreen")[0]
	LevelManagers = get_tree().get_nodes_in_group("LevelManager")
	SetCurrentLevel(get_tree().get_current_scene().get_name())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (!IsPlayerAlive && !activated):
		activated = true
		TeleportPlayer()

func GetPlayerAliveState():
	return IsPlayerAlive

func SetPlayerAliveState(playerState):
	IsPlayerAlive = playerState
	IsGamePlaying = playerState

func SetCurrentLevel(newLevel):
	SunStaffAltarObjects.clear()
	CurrentLevel = newLevel

func GetCurrentLevel():
	return CurrentLevel

func SetLastLivingPos(position): # Pressure Plate executes with its' position so the player can respawn there
	LastLivingPos = position

func GetSunStaffAltars():
	SunStaffAltarObjects = get_tree().get_nodes_in_group("StaffAltar")
	return SunStaffAltarObjects

func GetGemPedestals():
	return get_tree().get_nodes_in_group("GemPedestal")

func GetLevers():
	return get_tree().get_nodes_in_group("Lever")

func GetGemStates():
	return GemsCollected

func GetLevelManagers():
	return LevelManagers

func TeleportPlayer():
	Player.PlayerDeath(LastLivingPos) 
	GameManager.SetPlayerAliveState(true)
	GameManager.activated = false

func ToggleGem(color):
	match color:
		"Green":
			if (GemsCollected.get("Green")):
				GemsCollected.Green = false
			else:
				GemsCollected.Green = true
		"Red":
			if (GemsCollected.get("Red")):
				GemsCollected.Red = false
			else:
				GemsCollected.Red = true
		"Blue":
			if (GemsCollected.get("Blue")):
				GemsCollected.Blue = false
			else:
				GemsCollected.Blue = true
		"Cyan":
			if (GemsCollected.get("Cyan")):
				GemsCollected.Cyan = false
			else:
				GemsCollected.Cyan = true
		"Magenta":
			if (GemsCollected.get("Magenta")):
				GemsCollected.Magenta = false
			else:
				GemsCollected.Magenta = true

func OpenGemSelectionScreen(currentPedestal):
	GemSelectionScreen.ButtonsToBePlaced()
	GemSelectionScreen.visible = true
	IsGamePlaying = false
	pedestal = currentPedestal
	# Player will select gem
	# GemToBePlaced will execute

func GemToBePlaced(color):
	placedGem = color
	PlaceGem()

func PlaceGem():
	# Close Gem Selection Window
	GemSelectionScreen.visible = false
	# Make Game Playable
	IsGamePlaying = true
	# ToggleGem will execute
	ToggleGem(placedGem)
	# currentGemPedestal will sprite change to correct gem-pedestal combination
	var pedestalSprite = pedestal.get_child(0)

func CheckForLevelSpecificActions(from, information, optionalNode):
	print(CurrentLevel)
	match CurrentLevel:
		"Tutorial":
			pass
		"Level1":
			pass
		"Level2":
			pass
		"Level3":
			if ("Altar" in from):
				if ("_MoveDoor" in optionalNode.get_parent().get_parent().name):
					LevelManagers[0].Level3_MoveDoor_DueTo_StaffAltar(information)
