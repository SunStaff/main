extends Node

export var IsPlayerAlive = true
export var LevelState = Dictionary()
export var CollectibleCount = 0
export var CurrentLevel = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func GetCollectibleCount():
	return CollectibleCount

func AddCollectible():
	CollectibleCount += 1

func RemoveCollectible():
	CollectibleCount -= 1

func UpdateLevelState(nLevelState):
	LevelState.clear()
	LevelState = nLevelState.copy()

func GetLevelState():
	return LevelState

func GetPlayerAliveState():
	return IsPlayerAlive

func SetPlayerAliveState(playerState):
	IsPlayerAlive = playerState

func SetCurrentLevel(newLevel):
	CurrentLevel = newLevel

func GetCurrentLevel():
	return CurrentLevel

