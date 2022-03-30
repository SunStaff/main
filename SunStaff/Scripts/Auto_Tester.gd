extends Node

class_name AutoTester

var Milo


# Called when the node enters the scene tree for the first time.
func _ready():
	Milo = GameManager.GetPlayer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func Execute():
	var results = []
	results.append(Test_LeverManager_Distance_Normal())
	results.append(Test_LeverManager_Distance_AllLeversSamePosition())
	results.append(Test_LeverManager_LeverFlipped_Tutorial())
	results.append(Test_LeverManager_LeverFlipped_Level1())
	results.append(Test_LeverManager_LeverFlipped_Level2())
	results.append(Test_LeverManager_LeverFlipped_Level3())
	results.append(Test_LeverManager_LeverFlipped_NotCorrectLevel())

	results.append(Test_PressurePlateManager_PlateTouched_Tutorial())
	results.append(Test_PressurePlateManager_PlateTouched_Level1())
	results.append(Test_PressurePlateManager_PlateTouched_Level2())
	results.append(Test_PressurePlateManager_PlateTouched_Level3())
	results.append(Test_PressurePlateManager_PlateTouched_NotCorrectLevel())

	results.append(Test_GameManager_ToggleGem_GreenToggleOn())
	results.append(Test_GameManager_ToggleGem_GreenToggleOff())
	results.append(Test_GameManager_ToggleGem_BlueToggleOn())
	results.append(Test_GameManager_ToggleGem_BlueToggleOff())
	results.append(Test_GameManager_ToggleGem_RedToggleOn())
	results.append(Test_GameManager_ToggleGem_RedToggleOff())
	results.append(Test_GameManager_ToggleGem_CyanToggleOn())
	results.append(Test_GameManager_ToggleGem_CyanToggleOff())
	results.append(Test_GameManager_ToggleGem_MagentaToggleOn())
	results.append(Test_GameManager_ToggleGem_MagentaToggleOff())
	results.append(Test_GameManager_ToggleGem_IncorrectColor())

	for result in results:
		if (!result):
			print(result[1] + " Failed")
		else:
			print(result[1] + " Successful")


# LevelManager Tests
func Test_LeverManager_Distance_Normal():
	# Distance Testing
	var levers = []
	for i in range(5):
		var lever = Area2D.new()
		lever.position = Vector2(10*(i+1),0)
		levers.append(lever)
	var player = Area2D.new()
	player.position = Vector2(0,0)
	
	var expected = levers[0]
	var result = LeverManager.GetCurrentClosestLever(levers, player)
	if (result == expected):
		return [true, "LeverManager_Distance_Normal"]
	else:
		return [false, "LeverManager_Distance_Normal"]

func Test_LeverManager_Distance_AllLeversSamePosition():
	# Distance Testing
	var levers = []
	for i in range(5):
		var lever = Area2D.new()
		lever.position = Vector2(10,0)
		levers.append(lever)
	var player = Area2D.new()
	player.position = Vector2(0,0)
	
	var expected = levers[0]
	var result = LeverManager.GetCurrentClosestLever(levers, player)
	if (result == expected):
		return [true, "LeverManager_Distance_AllLeversSamePosition"]
	else:
		return [false, "LeverManager_Distance_AllLeversSamePosition"]
		
func Test_LeverManager_LeverFlipped_Tutorial():
	var level = "Tutorial"
	var lever = Area2D.new()
	lever.name = "Lever"
	var turnedOn = false

	var expected = "Tutorial"
	var result = LeverManager.LeverFlipped(level, lever, turnedOn)
	if (result == expected):
		return [true, "LeverManager_LeverFlipped_Tutorial"]
	else:
		return [false, "LeverManager_LeverFlipped_Tutorial"]

func Test_LeverManager_LeverFlipped_Level1():
	var level = "Level1"
	var lever = Area2D.new()
	lever.name = "Lever"
	var turnedOn = false

	var expected = "Tutorial"
	var result = LeverManager.LeverFlipped(level, lever, turnedOn)
	if (result == expected):
		return [true, "LeverManager_LeverFlipped_Level1"]
	else:
		return [false, "LeverManager_LeverFlipped_Level1"]

func Test_LeverManager_LeverFlipped_Level2():
	var level = "Level2"
	var lever = Area2D.new()
	lever.name = "Lever"
	var turnedOn = false

	var expected = "Tutorial"
	var result = LeverManager.LeverFlipped(level, lever, turnedOn)
	if (result == expected):
		return [true, "LeverManager_LeverFlipped_Level2"]
	else:
		return [false, "LeverManager_LeverFlipped_Level2"]

func Test_LeverManager_LeverFlipped_Level3():
	var level = "Level3"
	var lever = Area2D.new()
	lever.name = "Lever"
	var turnedOn = false

	var expected = "Tutorial"
	var result = LeverManager.LeverFlipped(level, lever, turnedOn)
	if (result == expected):
		return [true, "LeverManager_LeverFlipped_Level3"]
	else:
		return [false, "LeverManager_LeverFlipped_Level3"]

func Test_LeverManager_LeverFlipped_NotCorrectLevel():
	var level = "IncorrectLevel"
	var lever = Area2D.new()
	lever.name = "Lever"
	var turnedOn = false

	var expected = "Not Valid Level Name for LeverFlipped()"
	var result = LeverManager.LeverFlipped(level, lever, turnedOn)
	if (result == expected):
		return [true, "LeverManager_LeverFlipped_NotCorrectLevel"]
	else:
		return [false, "LeverManager_LeverFlipped_NotCorrectLevel"]

# PressurePlateManager Tests
func Test_PressurePlateManager_PlateTouched_Tutorial():
	var level = "Tutorial"
	var name = "PressurePlate"

	var expected = "Tutorial"
	var result = PressurePlateManager.PlateTouched(level, name)
	if (result == expected):
		return [true, "PressurePlateManager_PlateTouched_Tutorial"]
	else:
		return [false, "PressurePlateManager_PlateTouched_Tutorial"]

func Test_PressurePlateManager_PlateTouched_Level1():
	var level = "Level1"
	var name = "PressurePlate"

	var expected = "Level1"
	var result = PressurePlateManager.PlateTouched(level, name)
	if (result == expected):
		return [true, "PressurePlateManager_PlateTouched_Level1"]
	else:
		return [false, "PressurePlateManager_PlateTouched_Level1"]

func Test_PressurePlateManager_PlateTouched_Level2():
	var level = "Level2"
	var name = "PressurePlate"

	var expected = "Level2"
	var result = PressurePlateManager.PlateTouched(level, name)
	if (result == expected):
		return [true, "PressurePlateManager_PlateTouched_Level2"]
	else:
		return [false, "PressurePlateManager_PlateTouched_Level2"]

func Test_PressurePlateManager_PlateTouched_Level3():
	var level = "Level3"
	var name = "PressurePlate"

	var expected = "Level3"
	var result = PressurePlateManager.PlateTouched(level, name)
	if (result == expected):
		return [true, "PressurePlateManager_PlateTouched_Level3"]
	else:
		return [false, "PressurePlateManager_PlateTouched_Level3"]

func Test_PressurePlateManager_PlateTouched_NotCorrectLevel():
	var level = "IncorrectLevel"
	var name = "PressurePlate"

	var expected = "Not Valid Level Name for PlateTouched()"
	var result = PressurePlateManager.PlateTouched(level, name)
	if (result == expected):
		return [true, "PressurePlateManager_PlateTouched_NotCorrectLevel"]
	else:
		return [false, "PressurePlateManager_PlateTouched_NotCorrectLevel"]

# GameManager Tests
func Test_GameManager_ToggleGem_GreenToggleOn():
	var color = "Green"
	
	var expected = ["Green", true]
	var result = GameManager.ToggleGem(color)
	if (result == expected):
		return [true, "GameManager_ToggleGem_GreenToggleOn"]
	else:
		return [false, "GameManager_ToggleGem_GreenToggleOn"]

func Test_GameManager_ToggleGem_GreenToggleOff():
	var color = "Green"
	GameManager.GemsCollected = {"Green": true, "Blue": false, "Red": false, "Cyan": false, "Magenta": false }
	var expected = ["Green", false]
	var result = GameManager.ToggleGem(color)
	if (result == expected):
		return [true, "GameManager_ToggleGem_GreenToggleOff"]
	else:
		return [false, "GameManager_ToggleGem_GreenToggleOff"]

func Test_GameManager_ToggleGem_RedToggleOn():
	var color = "Red"
	
	var expected = ["Red", true]
	var result = GameManager.ToggleGem(color)
	if (result == expected):
		return [true, "GameManager_ToggleGem_RedToggleOn"]
	else:
		return [false, "GameManager_ToggleGem_RedToggleOn"]

func Test_GameManager_ToggleGem_RedToggleOff():
	var color = "Red"
	GameManager.GemsCollected = {"Green": false, "Blue": false, "Red": true, "Cyan": false, "Magenta": false }
	var expected = ["Red", false]
	var result = GameManager.ToggleGem(color)
	if (result == expected):
		return [true, "GameManager_ToggleGem_RedToggleOff"]
	else:
		return [false, "GameManager_ToggleGem_RedToggleOff"]

func Test_GameManager_ToggleGem_BlueToggleOn():
	var color = "Blue"
	
	var expected = ["Blue", true]
	var result = GameManager.ToggleGem(color)
	if (result == expected):
		return [true, "GameManager_ToggleGem_BlueToggleOn"]
	else:
		return [false, "GameManager_ToggleGem_BlueToggleOn"]

func Test_GameManager_ToggleGem_BlueToggleOff():
	var color = "Blue"
	GameManager.GemsCollected = {"Green": false, "Blue": true, "Red": false, "Cyan": false, "Magenta": false }
	var expected = ["Blue", false]
	var result = GameManager.ToggleGem(color)
	if (result == expected):
		return [true, "GameManager_ToggleGem_BlueToggleOff"]
	else:
		return [false, "GameManager_ToggleGem_BlueToggleOff"]

func Test_GameManager_ToggleGem_CyanToggleOn():
	var color = "Cyan"
	
	var expected = ["Cyan", true]
	var result = GameManager.ToggleGem(color)
	if (result == expected):
		return [true, "GameManager_ToggleGem_CyanToggleOn"]
	else:
		return [false, "GameManager_ToggleGem_CyanToggleOn"]

func Test_GameManager_ToggleGem_CyanToggleOff():
	var color = "Cyan"
	GameManager.GemsCollected = {"Green": false, "Blue": false, "Red": false, "Cyan": true, "Magenta": false }
	var expected = ["Cyan", false]
	var result = GameManager.ToggleGem(color)
	if (result == expected):
		return [true, "GameManager_ToggleGem_CyanToggleOff"]
	else:
		return [false, "GameManager_ToggleGem_CyanToggleOff"]

func Test_GameManager_ToggleGem_MagentaToggleOn():
	var color = "Magenta"
	
	var expected = ["Magenta", true]
	var result = GameManager.ToggleGem(color)
	if (result == expected):
		return [true, "GameManager_ToggleGem_MagentaToggleOn"]
	else:
		return [false, "GameManager_ToggleGem_MagentaToggleOn"]

func Test_GameManager_ToggleGem_MagentaToggleOff():
	var color = "Magenta"
	GameManager.GemsCollected = {"Green": false, "Blue": true, "Red": false, "Cyan": false, "Magenta": true }
	var expected = ["Magenta", false]
	var result = GameManager.ToggleGem(color)
	if (result == expected):
		return [true, "GameManager_ToggleGem_MagentaToggleOff"]
	else:
		return [false, "GameManager_ToggleGem_MagentaToggleOff"]

func Test_GameManager_ToggleGem_IncorrectColor():
	var color = "Color"

	var expected = ["Not Valid Gem Color for ToggleGem()", null]
	var result = GameManager.ToggleGem(color)
	if (result == expected):
		return [true, "GameManager_ToggleGem_IncorrectColor"]
	else:
		return [false, "GameManager_ToggleGem_IncorrectColor"]