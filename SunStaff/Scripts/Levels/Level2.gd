extends Node


export (bool) var DebugMode = false
export (Vector2) var MiloSpawnLocation = Vector2(0,0)
var allowSkinnyBlockMovement = false
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
	if (DebugMode):
		GameManager.SetLastLivingPos(MiloSpawnLocation)
		# GameManager.TeleportPlayer()
		GameManager.GetPlayer().position = MiloSpawnLocation
	
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
func _process(_delta):
	pass

#Similar code to Level3_TimerPuzzle, coordinate values are modified and 4th platform added
func Level2_TimerPuzzle():
	if (not timerActivated):
		timerActivated = true
		while (not allPlatformsUp):
			if (not platform1):
				timerPuzzle_Array[0].position.y -= 50
				if (timerPuzzle_Array[0].position.y <= -30):
					platform1 = true

			if (not platform2):
				timerPuzzle_Array[1].position.y -= 50
				if (timerPuzzle_Array[1].position.y <= -275):
					platform2 = true

			if (not platform3):
				timerPuzzle_Array[2].position.y -= 50
				if (timerPuzzle_Array[2].position.y <= 45):
					platform3 = true
			
			if (not platform4):
				timerPuzzle_Array[3].position.y -= 50
				if (timerPuzzle_Array[3].position.y <= -200):
					platform4 = true			
			
			if (platform1 and platform2 and platform3 and platform4):
				allPlatformsUp = true

			timer.set_wait_time(0.1)
			timer.set_one_shot(true)
			timer.start()
			yield(timer, "timeout")

		while (timerPuzzle_Array[0].position.y < 1600 or
			timerPuzzle_Array[1].position.y < 1600 or
			timerPuzzle_Array[2].position.y < 1600 or 
			timerPuzzle_Array[3].position.y < 1600):
			for platform in timerPuzzle_Array:
				platform.position.y += 50
				timer.set_wait_time(0.5)
				timer.set_one_shot(true)
				timer.start()
				yield(timer, "timeout")
		timerActivated = false


func Destroy_SkinnyBlockBlocker():
	#Destroy skinnyBlockBlocker node from the scene
	skinnyBlockBlocker.queue_free()
	allowSkinnyBlockMovement = true

func Destroy_SmallBlockBlocker():
	#Destroy smallBlockBlocker node from the scene
	smallBlockBlocker.queue_free()

func Open_FinalDoor():
	#Final door motions downward
	while(not finalDoorOpened):
		finalDoor.position.y += 25
		if(finalDoor.position.y >= 600):
			finalDoorOpened = true

func _on_EndLevel2_body_entered(body):
	if ("Milo" in body.name):
		GameManager.ChangeScene()
