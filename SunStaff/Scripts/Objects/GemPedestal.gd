extends Area2D

# Pedestal Variables
var WithinPedestalRange
var CurrentClosestPedestal
var minDistanceToPedestal = INF
var Pedestals = []
var PedestalName = ""
var PedestalSprite
onready var shader = self.material

# Called when the node enters the scene tree for the first time.
func _ready():
	WithinPedestalRange = false
	PedestalSprite = self.get_child(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (PedestalSprite.frame == 0):
		PedestalSprite.position = Vector2(0, 40)
	else:
		PedestalSprite.position = Vector2(0, 0)
	GlowMaterial(false)
	if (WithinPedestalRange):
		GlowMaterial(true)
		var frameNumber = PedestalSprite.frame
		if (Input.is_action_just_pressed("Interact")):
			if (GetCurrentClosestPedestal(GameManager.GetGemPedestals(), GameManager.GetPlayer()) == self):
				var LevelManager = GameManager.GetLevelManager()
				if (frameNumber > 0):
					match frameNumber:
						1:
							GameManager.ToggleGem("Blue")
							PedestalSprite.frame = 0
							LevelManager.ChangePedestalBeamColors("", false, self)
							AudioManager.get_script().PlayCollectable()
						2:
							GameManager.ToggleGem("Green")
							PedestalSprite.frame = 0
							LevelManager.ChangePedestalBeamColors("", false, self)
							AudioManager.get_script().PlayCollectable()
						3:
							GameManager.ToggleGem("Magenta")
							PedestalSprite.frame = 0
							LevelManager.ChangePedestalBeamColors("", false, self)
							AudioManager.get_script().PlayCollectable()
						4:
							GameManager.ToggleGem("Cyan")
							PedestalSprite.frame = 0
							LevelManager.ChangePedestalBeamColors("", false, self)
							AudioManager.get_script().PlayCollectable()
						5:
							GameManager.ToggleGem("Red")
							PedestalSprite.frame = 0
							LevelManager.ChangePedestalBeamColors("", false, self)
							AudioManager.get_script().PlayCollectable()
				else:
					LevelManager.OpenGemSelectionScreen(CurrentClosestPedestal)
			

func _on_GemPedestal_body_entered(body):
	if ("Milo" in body.name):
		WithinPedestalRange = true

func _on_GemPedestal_body_exited(body):
	if ("Milo" in body.name):
		WithinPedestalRange = false

func GetCurrentClosestPedestal(pedestals, player):
	CurrentClosestPedestal = null
	# Get Current Closest Pedestal
	for pedestal in pedestals:
		var distanceTo =player.position.distance_to(pedestal.global_position)
		if (distanceTo <= minDistanceToPedestal):
			minDistanceToPedestal = distanceTo
			CurrentClosestPedestal = pedestal
	minDistanceToPedestal = INF
	return CurrentClosestPedestal

func GlowMaterial(state):
	if (state):
		shader.set_shader_param("color", Color(1,1,1,1.0))
	else:
		shader.set_shader_param("color", Color(1,1,1,0))
