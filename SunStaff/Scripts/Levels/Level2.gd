extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var skinnyBlock
var skinnyBlockBlocker
var largeBlock
var smallBlockBlocker
var smallBlock
var finalDoor
var finalDoorOpened = false
var leverDoor
var leverDoorOpened = false

var timerPuzzle_Array = []
var timer
var timerActivated = false

#Timer platforms are NOT in activated positions
var allPlatformsUp = false
var platform1 = false
var platform2 = false
var platform3 = false
var platform4 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	finalDoor = get_parent().get_node("BlockPuzzle/FinalDoor")
	leverDoor = get_parent().get_node("LeverPuzzle/PuzzleDoor")
	#Block Puzzle elements initialized (Last puzzle)
	skinnyBlockBlocker = get_parent().get_node("BlockPuzzle/SkinnyBlockFloorBlocker")
	skinnyBlock = get_parent().get_node("BlockPuzzle/SkinnyBlock")
	largeBlock = get_parent().get_node("BlockPuzzle/LargeBlock")
	smallBlockBlocker = get_parent().get_node("BlockPuzzle/SmallBlockBlocker")
	smallBlock = get_parent().get_node("BlockPuzzle/SmallBlock")

	#Timed-Platforming elements (First puzzle)
	timerPuzzle_Array.append(get_parent().get_node("TimerPuzzle/TimerPlatform1"))
	timerPuzzle_Array.append(get_parent().get_node("TimerPuzzle/TimerPlatform2"))
	timerPuzzle_Array.append(get_parent().get_node("TimerPuzzle/TimerPlatform3"))
	timerPuzzle_Array.append(get_parent().get_node("TimerPuzzle/TimerPlatform4"))

	timer = Timer.new()
	self.add_child(timer)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#Similar code to Level3_TimerPuzzle, coordinate values are modified and 4th platform added
func Level2_TimerPuzzle():
	if (not timerActivated):
		timerActivated = true
		while (not allPlatformsUp):
			if (not platform1):
				timerPuzzle_Array[0].position.y -= 50
				if (timerPuzzle_Array[0].position.y <= -175):
					platform1 = true

			if (not platform2):
				timerPuzzle_Array[1].position.y -= 50
				if (timerPuzzle_Array[1].position.y <= -350):
					platform2 = true

			if (not platform3):
				timerPuzzle_Array[2].position.y -= 50
				if (timerPuzzle_Array[2].position.y <= -525):
					platform3 = true
			
			if (not platform4):
				timerPuzzle_Array[3].position.y -= 50
				if (timerPuzzle_Array[3].position.y <= -700):
					platform4 = true			
			
			if (platform1 and platform2 and platform3 and platform4):
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


func Destroy_SkinnyBlockBlocker():
	#Destroy skinnyBlockBlocker node from the scene
	skinnyBlockBlocker.queue_free()

func Destroy_SmallBlockBlocker():
	#Destroy smallBlockBlocker node from the scene
	smallBlockBlocker.queue_free()

	#Force allows the block to fall after the block is removed
	smallBlock.apply_impulse(Vector2(), Vector2(0, 5))

func Open_FinalDoor():
	#Final door motions downward
	while(not finalDoorOpened):
		finalDoor.position.y += 25
		if(finalDoor.position.y >= -100):
			finalDoorOpened = true
