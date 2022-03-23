extends Node

export var IsPlayerAlive = true
export var IsGamePlaying = true
export var CollectibleCount = 0
export var CurrentLevel = ""
export var LastLivingPos = Vector2()
export var SunStaffAltarObjects = []
export var GemsCollected = {"Green": false, "Blue": false, "Red": false, "Cyan": false, "Magenta": false }
var placedGem = ""
var activated
var Player
var GemSelectionScreen
var pedestal



# Called when the node enters the scene tree for the first time.
func _ready():
	activated = false
	LastLivingPos = Vector2(0,55)
	Player = get_tree().get_nodes_in_group("Player")[0]
	GemSelectionScreen = get_tree().get_nodes_in_group("GemSelectionScreen")[0]
	SetCurrentLevel(get_tree().get_current_scene().get_name())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (!IsPlayerAlive && !activated):
		activated = true
		TeleportPlayer()

func GetCollectibleCount():
	return CollectibleCount

func AddCollectible():
	CollectibleCount += 1

func RemoveCollectible():
	CollectibleCount -= 1

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

func TeleportPlayer():
	Player.PlayerDeath(LastLivingPos) 
	GameManager.SetPlayerAliveState(true)
	GameManager.activated = false

func GetSunStaffAltars():
	SunStaffAltarObjects = get_tree().get_nodes_in_group("StaffAltar")
	return SunStaffAltarObjects

func GetGemPedestals():
	return get_tree().get_nodes_in_group("GemPedestal")

func GetLevers():
	return get_tree().get_nodes_in_group("Lever")

func GetGemStates():
	return GemsCollected

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
	print("GemsCollected", GemsCollected)

func OpenGemSelectionScreen(currentPedestal):
	GemSelectionScreen.ButtonsToBePlaced()
	GemSelectionScreen.visible = true
	print("Gem Screen Visible")
	IsGamePlaying = false
	pedestal = currentPedestal
	# Player will select gem
	# GemToBePlaced will execute

func GemToBePlaced(color):
	placedGem = color
	print("Placed Gem", placedGem)
	PlaceGem()

func PlaceGem():
	# Close Gem Selection Window
	GemSelectionScreen.visible = false
	print("Gem Screen Not Visible")
	# Make Game Playable
	IsGamePlaying = true
	# ToggleGem will execute
	ToggleGem(placedGem)
	# currentGemPedestal will sprite change to correct gem-pedestal combination
	var pedestalSprite = pedestal.get_child(0)
