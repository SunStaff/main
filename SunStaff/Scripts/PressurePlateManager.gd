extends Node

var LevelManager

func PlateTouched(level, name):
	LevelManager = GameManager.GetLevelManager()
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
			LevelManager.OffsetCamera()
		"2":
			LevelManager.OriginalCamera()

func Level2(name):
	name = name.replacen("PressurePlate", "")
	match(name):
		#Sets off timer puzzle
		"1":
			LevelManager.Level2_PlatformFall()
		#Pressure Plate for LargeBlock
		"2":
			LevelManager.Destroy_SkinnyBlockGate()

		#Pressure Plate for SkinnyBlock
		"3":
			LevelManager.Destroy_SmallBlockBlocker()

		#Pressure Plate for SmallBlock
		"4":
			LevelManager.Open_FinalDoor()
		"5":
			LevelManager.Level2_PlatformFall()

func Level3(name):
	name = name.replacen("PressurePlate", "")
	match(name):
		"1":
			LevelManager.Level3_TimerPuzzle()
		"2":
			LevelManager.Level3_OpenBottomPuzzles()
		"3":
			LevelManager.ClearSavePoints()
