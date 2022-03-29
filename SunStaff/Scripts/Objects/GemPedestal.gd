extends Area2D

# Pedestal Variables
var WithinPedestalRange
var CurrentClosestPedestal
var minDistanceToPedestal = INF
var Pedestals = []
var PedestalName = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	WithinPedestalRange = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (WithinPedestalRange):
		if (Input.is_action_just_pressed("Interact")):
			print("interaction with pedestal")
			if (GetCurrentClosestPedestal() == self):
				if (self.get_child(0).frame != 0):
					match self.get_child(0).frame:
						1:
							GameManager.ToggleGem("Blue")
							self.get_child(0).frame = 0
							GameManager.GetLevelManagers()[0].ChangePedestalBeamColors("", false)
						2:
							GameManager.ToggleGem("Green")
							self.get_child(0).frame = 0
							GameManager.GetLevelManagers()[0].ChangePedestalBeamColors("", false)
						3:
							GameManager.ToggleGem("Magenta")
							self.get_child(0).frame = 0
							GameManager.GetLevelManagers()[0].ChangePedestalBeamColors("", false)
						4:
							GameManager.ToggleGem("Cyan")
							self.get_child(0).frame = 0
							GameManager.GetLevelManagers()[0].ChangePedestalBeamColors("", false)
						5:
							GameManager.ToggleGem("Red")
							self.get_child(0).frame = 0
							GameManager.GetLevelManagers()[0].ChangePedestalBeamColors("", false)
				else:
					GameManager.GetLevelManagers()[0].OpenGemSelectionScreen(CurrentClosestPedestal)
			

func _on_GemPedestal_body_entered(body):
	if ("Milo" in body.name):
		WithinPedestalRange = true

func _on_GemPedestal_body_exited(body):
	if ("Milo" in body.name):
		WithinPedestalRange = false

func GetCurrentClosestPedestal():
	Pedestals.clear()
	for pedestal in GameManager.GetGemPedestals():
		Pedestals.append(pedestal)
	# Get Current Closest Pedestal
	for pedestal in Pedestals:
		var distanceTo = GameManager.DistanceTo(pedestal.position, GameManager.GetPlayer().position)
		if (distanceTo < minDistanceToPedestal):
			minDistanceToPedestal = distanceTo
			CurrentClosestPedestal = pedestal
	minDistanceToPedestal = INF
	return CurrentClosestPedestal
