extends Node

export var IsPlayerAlive = true
export var CollectibleCount = 0
export var CurrentLevel = ""
export var LastLivingPos = Vector2()
export var SunStaffAltarObjects = []
export var GemsCollected = {"Green": false, "Blue": false, "Red": false, "Cyan": false, "Magenta": false }
var activated
var Player



# Called when the node enters the scene tree for the first time.
func _ready():
	activated = false
	LastLivingPos = Vector2(0,55)
	Player = get_tree().get_nodes_in_group("Player")[0]
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