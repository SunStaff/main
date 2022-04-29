extends Control

var Gems = {}
var CurrentGems = []
var BlueButton
var GreenButton
var RedButton
var CyanButton
var MagentaButton
var LevelManager

# Called when the node enters the scene tree for the first time.
func _ready():
	Gems = GameManager.GetGemStates().values()
	GreenButton = get_child(1).get_child(0).get_child(0).get_child(0)
	BlueButton = get_child(1).get_child(0).get_child(0).get_child(1)
	RedButton = get_child(1).get_child(0).get_child(0).get_child(2)
	CyanButton = get_child(1).get_child(0).get_child(0).get_child(3)
	MagentaButton = get_child(1).get_child(0).get_child(0).get_child(4)
	LevelManager = GameManager.GetLevelManager()


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(_delta):
# 	pass
	
func ButtonsToBePlaced():
	GameManager.GemSelectionScreenOpen = true
	Gems = GameManager.GetGemStates().values()
	GreenButton.visible = false
	BlueButton.visible = false
	RedButton.visible = false
	CyanButton.visible = false
	MagentaButton.visible = false
	if (Gems[0]):
		CurrentGems.append(GreenButton)

	if (Gems[1]):
		CurrentGems.append(BlueButton)
	
	if (Gems[2]):
		CurrentGems.append(RedButton)

	if (Gems[3]):
		CurrentGems.append(CyanButton)

	if (Gems[4]):
		CurrentGems.append(MagentaButton)

	MakeButtonsVisible(len(CurrentGems))
	CurrentGems.clear()

func MakeButtonsVisible(length):
	for i in range(length):
		CurrentGems[i].visible = true

func _on_Green_Gem_pressed():
	LevelManager.GemToBePlaced("Green")

func _on_Blue_Gem_pressed():
	LevelManager.GemToBePlaced("Blue")


func _on_Red_Gem_pressed():
	LevelManager.GemToBePlaced("Red")


func _on_Magenta_Gem_pressed():
	LevelManager.GemToBePlaced("Magenta")

func _on_Cyan_Gem_pressed():
	LevelManager.GemToBePlaced("Cyan")

func _on_Button_pressed():
	self.visible = false
	GameManager.GemSelectionScreenOpen = false
	GameManager.IsGamePlaying = true
