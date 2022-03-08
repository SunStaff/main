extends Node

export var LevelState = Dictionary()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func UpdateLevelState(nLevelState):
	LevelState.clear()
	LevelState = nLevelState.copy()

func GetLevelState():
	return LevelState
# 2-4 Checkpoints per level
# each checkpoint contains:
	# Checkpoint Number
	# Checkpoint Position
	# Checked or Not
# Once a checkpoint is activated the system will grab replace LevelState to be current
	# current = All puzzle states before said checkpoint are saved
# Once player dies, they teleport to current Checkpoint, 
# current LevelState is overwritten with saved LevelState
# Player set to alive

func TeleportPlayer():
	get_tree().get_nodes_in_group("Player")[0].PlayerDeath(Vector2(0,55)) 
	GameManager.SetPlayerAliveState(true)
	GameManager.activated = false
