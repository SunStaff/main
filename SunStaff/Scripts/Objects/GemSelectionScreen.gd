extends Control

var Gems = {}
var PositionPlacements = [Vector2(234,390),Vector2(534,390),Vector2(834,390),Vector2(1134,390),Vector2(1434,390)]
var CurrentGems = []
var BlueButton
var GreenButton
var RedButton
var CyanButton
var MagentaButton

# Called when the node enters the scene tree for the first time.
func _ready():
	Gems = GameManager.GetGemStates().values()
	GreenButton = get_child(1)
	BlueButton = get_child(2)
	RedButton = get_child(3)
	CyanButton = get_child(4)
	MagentaButton = get_child(5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func ButtonsToBePlaced():
	Gems = GameManager.GetGemStates().values()
	print("Gems", Gems)
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

	PlaceButtons()
	CurrentGems.clear()

func PlaceButtons():
	match len(CurrentGems):
		0:
			pass
		1:
			CurrentGems[0].set_position(PositionPlacements[2])
		2:
			CurrentGems[0].set_position(PositionPlacements[1])
			CurrentGems[1].set_position(PositionPlacements[3])
		3:
			CurrentGems[0].set_position(PositionPlacements[1])
			CurrentGems[1].set_position(PositionPlacements[2])
			CurrentGems[2].set_position(PositionPlacements[3])
		4:
			CurrentGems[0].set_position(PositionPlacements[0])
			CurrentGems[1].set_position(PositionPlacements[1])
			CurrentGems[2].set_position(PositionPlacements[3])
			CurrentGems[3].set_position(PositionPlacements[4])
		5:
			CurrentGems[0].set_position(PositionPlacements[0])
			CurrentGems[1].set_position(PositionPlacements[1])
			CurrentGems[2].set_position(PositionPlacements[2])
			CurrentGems[3].set_position(PositionPlacements[3])
			CurrentGems[4].set_position(PositionPlacements[4])
	MakeButtonsVisible(len(CurrentGems))

func MakeButtonsVisible(length):
	for i in range(length):
		CurrentGems[i].visible = true


func _on_Green_Gem_pressed():
	GameManager.GemToBePlaced("Green")


func _on_Blue_Gem_pressed():
	GameManager.GemToBePlaced("Blue")


func _on_Red_Gem_pressed():
	GameManager.GemToBePlaced("Red")


func _on_Cyan_Gem_pressed():
	GameManager.GemToBePlaced("Cyan")


func _on_Magenta_Gem_pressed():
	GameManager.GemToBePlaced("Magenta")
