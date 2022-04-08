extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var LevelManagers = []

# Called when the node enters the scene tree for the first time.
func _ready():
	LevelManagers = GameManager.GetLevelManagers()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func PlateTouched(level, name):
	LevelManagers.clear()
	LevelManagers = GameManager.GetLevelManagers()
	match(level):
		"Tutorial":
			Tutorial(name)
			return "Tutorial"
		"Level1":
			Level1(name)
			return "Level1"
		"Level2":
			Level2(name)
			return "Level2"
		"Level3":
			Level3(name)
			return "Level3"
		_:
			print("Not Valid Level Name for PlateTouched()")
			return "Not Valid Level Name for PlateTouched()"

func Tutorial(name):
	name = name.replacen("PressurePlate", "")
	match(name):
		"1":
			pass
		"2":
			pass

func Level1(name):
	name = name.replacen("PressurePlate", "")
	match(name):
		"1":
			pass
		"2":
			pass

func Level2(name):
	name = name.replacen("PressurePlate", "")
	match(name):
		#Sets off timer puzzle
		"1":
			LevelManagers[0].Level2_TimerPuzzle()
		#Pressure Plate for LargeBlock
		"2":
			print("Removing Skinny Block Barrier")
			LevelManagers[0].Destroy_SkinnyBlockBlocker()

		#Pressure Plate for SkinnyBlock
		"3":
			print("Small Block Dropping")
			LevelManagers[0].Destroy_SmallBlockBlocker()

		#Pressure Plate for SmallBlock
		"4":
			print("Final Door opened")
			LevelManagers[0].Open_FinalDoor()

func Level3(name):
	name = name.replacen("PressurePlate", "")
	match(name):
		"1":
			LevelManagers[0].Level3_TimerPuzzle()
		"2":
			LevelManagers[0].Level3_OpenBottomPuzzles()
