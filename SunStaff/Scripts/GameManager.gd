extends Node

export var IsPlayerAlive = true
export var CollectibleCount = 0
export var CurrentLevel = ""
var activated
var checkpoints

# Called when the node enters the scene tree for the first time.
func _ready():
	activated = false
	checkpoints = get_node("/root/Checkpoints")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!IsPlayerAlive && !activated):
		activated = true
		checkpoints.TeleportPlayer()

func GetCollectibleCount():
	return CollectibleCount

func AddCollectible():
	CollectibleCount += 1

func RemoveCollectible():
	CollectibleCount -= 1

func GetPlayerAliveState():
	return IsPlayerAlive

func SetPlayerAliveState(playerState):
	print("Player State Changed")
	IsPlayerAlive = playerState

func SetCurrentLevel(newLevel):
	CurrentLevel = newLevel

func GetCurrentLevel():
	return CurrentLevel

