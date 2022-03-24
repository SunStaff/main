extends Node

var level3_door
var timerPuzzle_Array = []
var timer
var timerActivated = false

# Called when the node enters the scene tree for the first time.
func _ready():
	level3_door = get_parent().get_node("StartingDoor")
	print(level3_door)
	timerPuzzle_Array.append(get_parent().get_node("TimerPlatform1"))
	timerPuzzle_Array.append(get_parent().get_node("TimerPlatform2"))
	timerPuzzle_Array.append(get_parent().get_node("TimerPlatform3"))
	timer = Timer.new()
	self.add_child(timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func Level3_MoveDoor_DueTo_StaffAltar(open):
	if (open):
		while (level3_door.position.y < 500):
			level3_door.position.y += 50
			timer.set_wait_time(0.1)
			timer.set_one_shot(true)
			timer.start()
			yield(timer, "timeout")
	else:
		while (level3_door.position.y > -150):
			level3_door.position.y -= 50
			timer.set_wait_time(0.01)
			timer.set_one_shot(true)
			timer.start()
			yield(timer, "timeout")

func Level3_TimerPuzzle():
	var allPlatformsUp = false
	var platform1 = false
	var platform2 = false
	var platform3 = false
	if (not timerActivated):
		timerActivated = true
		while (not allPlatformsUp):
			if (not platform1):
				timerPuzzle_Array[0].position.y -= 50
				if (timerPuzzle_Array[0].position.y <= 320):
					platform1 = true

			if (not platform2):
				timerPuzzle_Array[1].position.y -= 50
				if (timerPuzzle_Array[1].position.y <= 480):
					platform2 = true

			if (not platform3):
				timerPuzzle_Array[2].position.y -= 50
				if (timerPuzzle_Array[2].position.y <= 310):
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
				timer.set_wait_time(.75)
				timer.set_one_shot(true)
				timer.start()
				yield(timer, "timeout")
