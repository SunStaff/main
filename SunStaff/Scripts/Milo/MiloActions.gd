extends Node

var playerRootNode

# Called when the node enters the scene tree for the first time.
func _ready():
	playerRootNode = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func PlayerDeath(position):
	playerRootNode.position = position
