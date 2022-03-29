extends Node

var level3_door
var timerPuzzle_Array = []
var timer
var timerActivated = false
var GemSelectionScreen
var pedestal
var placedGem
var darkPressurePlateNotSteppedOn = true
var allPlatformsUp = false
var platform1 = false
var platform2 = false
var platform3 = false
var Pedestals = []
var StaffAltars = []
var Level3Complete = false
var Diamond 
var EndDoor 
var EndLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	level3_door = get_parent().get_node("StartingDoor")
	Diamond = self.get_parent().get_node("WhiteDimondForPuzzle")
	EndDoor = self.get_parent().get_node("EndDoor")
	EndLevel = self.get_parent().get_node("EndLevel")
	EndLevel.visible = false
	EndLevel.monitoring = false
	timerPuzzle_Array.append(get_parent().get_node("TimerPuzzle/TimerPlatform1"))
	timerPuzzle_Array.append(get_parent().get_node("TimerPuzzle/TimerPlatform2"))
	timerPuzzle_Array.append(get_parent().get_node("TimerPuzzle/TimerPlatform3"))
	timer = Timer.new()
	self.add_child(timer)
	GemSelectionScreen = get_tree().get_nodes_in_group("GemSelectionScreen")[0]
	darkPressurePlateNotSteppedOn = false
	Pedestals = GameManager.GetGemPedestals()
	StaffAltars = GameManager.GetSunStaffAltars()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (not Level3Complete):
		if (Pedestals[0].get_child(0).frame == 5):
			if (Pedestals[1].get_child(0).frame == 3):
				if (Pedestals[2].get_child(0).frame == 1):
					if (Pedestals[3].get_child(0).frame == 4):
						if (Pedestals[4].get_child(0).frame == 2):
							if (StaffAltars[2].activated):
								Level3Complete = true
								OpenTheEnd()


func Level3_MoveDoor_DueTo_StaffAltar(open):
	if (open):
		while (level3_door.position.y < 500):
			level3_door.position.y += 50
			timer.set_wait_time(0.1)
			timer.set_one_shot(true)
			timer.start()
			yield(timer, "timeout")
	elif(darkPressurePlateNotSteppedOn):
		while (level3_door.position.y > -150):
			level3_door.position.y -= 50
			timer.set_wait_time(0.01)
			timer.set_one_shot(true)
			timer.start()
			yield(timer, "timeout")

func Level3_OpenBottomPuzzles():
	darkPressurePlateNotSteppedOn = false
	allPlatformsUp = false
	platform1 = false
	platform2 = false
	platform3 = false
	while (level3_door.position.y < 500):
		level3_door.position.y += 50
		timer.set_wait_time(0.1)
		timer.set_one_shot(true)
		timer.start()
		yield(timer, "timeout")

	if (not timerActivated):
		timerActivated = true
		while (not allPlatformsUp):
			if (not platform1):
				timerPuzzle_Array[0].position.y -= 50
				if (timerPuzzle_Array[0].position.y <= 415):
					platform1 = true

			if (not platform2):
				timerPuzzle_Array[1].position.y -= 50
				if (timerPuzzle_Array[1].position.y <= 550):
					platform2 = true

			if (not platform3):
				timerPuzzle_Array[2].position.y -= 50
				if (timerPuzzle_Array[2].position.y <= 660):
					platform3 = true
			
			if (platform1 and platform2 and platform3):
				allPlatformsUp = true
			timer.set_wait_time(0.1)
			timer.set_one_shot(true)
			timer.start()
			yield(timer, "timeout")

func Level3_TimerPuzzle():
	if (not timerActivated):
		timerActivated = true
		while (not allPlatformsUp):
			if (not platform1):
				timerPuzzle_Array[0].position.y -= 50
				if (timerPuzzle_Array[0].position.y <= 415):
					platform1 = true

			if (not platform2):
				timerPuzzle_Array[1].position.y -= 50
				if (timerPuzzle_Array[1].position.y <= 550):
					platform2 = true

			if (not platform3):
				timerPuzzle_Array[2].position.y -= 50
				if (timerPuzzle_Array[2].position.y <= 660):
					platform3 = true
			
			if (platform1 and platform2 and platform3):
				allPlatformsUp = true

			timer.set_wait_time(0.1)
			timer.set_one_shot(true)
			timer.start()
			yield(timer, "timeout")

		for platform in timerPuzzle_Array:
			while(platform.position.y < 1000):
				platform.position.y += 50
				timer.set_wait_time(.5)
				timer.set_one_shot(true)
				timer.start()
				yield(timer, "timeout")
		timerActivated = false

func OpenTheEnd():
	print(Diamond, EndDoor, EndLevel)
	Diamond.modulate = Color(1,1,1)
	EndDoor.position.y = -1060
	EndLevel.visible = true
	EndLevel.monitoring = true

func Level3End():
	print("End of Level 3")
	pass

func OpenGemSelectionScreen(currentPedestal):
	GemSelectionScreen.ButtonsToBePlaced()
	GemSelectionScreen.visible = true
	GameManager.IsGamePlaying = false
	pedestal = currentPedestal
	# Player will select gem
	# GemToBePlaced will execute

func GemToBePlaced(color):
	placedGem = color
	PlaceGem()

func PlaceGem():
	# Close Gem Selection Window
	GemSelectionScreen.visible = false
	# Make Game Playable
	GameManager.IsGamePlaying = true
	# ToggleGem will execute
	GameManager.ToggleGem(placedGem)
	# currentGemPedestal will sprite change to correct gem-pedestal combination
	var pedestalSprite = pedestal.get_child(0)
	match placedGem:
		"Blue":
			pedestalSprite.frame = 1
		"Green":
			pedestalSprite.frame = 2
		"Magenta":
			pedestalSprite.frame = 3
		"Cyan":
			pedestalSprite.frame = 4
		"Red":
			pedestalSprite.frame = 5
	ChangePedestalBeamColors(placedGem, true)

func ChangePedestalBeamColors(color, toggle):
	var BeamColor = Color(0,0,0)
	var BeamsNode = pedestal.get_node("Beams")
	var BeamsArray = BeamsNode.get_children()
	if (toggle):
		match color:
			"Blue":
				BeamColor = Color(0,0,1)
			"Green":
				BeamColor = Color(0,1,0)
			"Red":
				BeamColor = Color(1,0,0)
			"Magenta":
				BeamColor = Color(1,0,1)
			"Cyan":
				BeamColor = Color (0,1,1)

		for beam in BeamsArray:
			beam.modulate = BeamColor
			timer.set_wait_time(.5)
			timer.set_one_shot(true)
			timer.start()
			yield(timer, "timeout")
			beam.visible = true
	else:
		for beam in BeamsArray:
			beam.modulate = Color(1,1,1)
			timer.set_wait_time(.5)
			timer.set_one_shot(true)
			timer.start()
			yield(timer, "timeout")
			beam.visible = false

func ChangeAltarBeamColors(toggle, altar):
	var BeamsNode = altar.get_node("Beams")
	var BeamsArray = BeamsNode.get_children()
	if (toggle):
		var BeamColor = Color(1,1,0)
		for beam in BeamsArray:
			beam.modulate = BeamColor
			timer.set_wait_time(.5)
			timer.set_one_shot(true)
			timer.start()
			yield(timer, "timeout")
			beam.visible = true
	else:
		for beam in BeamsArray:
			beam.modulate = Color(1,1,1)
			timer.set_wait_time(.5)
			timer.set_one_shot(true)
			timer.start()
			yield(timer, "timeout")
			beam.visible = false

func _on_EndLevel_body_entered(body):
	if ("Milo" in body.name):
		Level3End()
