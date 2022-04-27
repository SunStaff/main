extends Node


export (bool) var DebugMode = false
export (Vector2) var MiloSpawnLocation = Vector2(0,0)
var allowSkinnyBlockMovement = false
var smallBlockFall = false
var skinnyBlock
var skinnyBlockGate
var largeBlock
var smallBlockBlocker
var smallBlock
var finalDoor
var finalDoorOpened = false

var ravinePlatform_Array = []
var ravine_nodeArray = []
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
	#Block Puzzle elements initialized (Last puzzle)
	skinnyBlock = get_parent().get_node("BlockPuzzle/SkinnyBlock")
	skinnyBlockGate = get_parent().get_node("BlockPuzzle/SkinnyBlockGate")
	largeBlock = get_parent().get_node("BlockPuzzle/LargeBlock")
	smallBlockBlocker = get_parent().get_node("BlockPuzzle/SmallBlockBlocker")
	smallBlock = get_parent().get_node("BlockPuzzle/SmallBlock")

	#Ravine Platforms that Fall
	ravinePlatform_Array.append(get_parent().get_node("PlatformFall/FallPlatform1"))
	ravinePlatform_Array.append(get_parent().get_node("PlatformFall/FallPlatform2"))
	ravinePlatform_Array.append(get_parent().get_node("PlatformFall/FallPlatform3"))
	ravinePlatform_Array.append(get_parent().get_node("PlatformFall/FallPlatform4"))

	ravine_nodeArray = get_parent().get_node("RavinePuzzle").get_children()

	for node in ravine_nodeArray:
		if ("Platform" in node.name and not "Unlit" in node.name):
			node.get_child(0).visible = false
			node.get_child(1).visible = false
			node.get_child(2).set_deferred("disabled", true)

	timer = Timer.new()
	self.add_child(timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func Level2_PlatformFall():	
	for i in range(len(ravinePlatform_Array)):
		if i > 0:
			ravinePlatform_Array[i].queue_free()

	timer.set_wait_time(0.5)
	timer.set_one_shot(true)
	timer.start()
	yield(timer, "timeout")

	while (ravinePlatform_Array[0].position.y < 1900):
		ravinePlatform_Array[0].position.y = lerp(ravinePlatform_Array[0].position.y, ravinePlatform_Array[0].position.y+100, 0.5)
		timer.set_wait_time(0.01)
		timer.set_one_shot(true)
		timer.start()
		yield(timer, "timeout")

	ravinePlatform_Array[0].queue_free()

func Level2_Ravine_FirstLever(state):
	var ravine_platform1 = get_parent().get_node("RavinePuzzle/UnlitOnlyPlatform1")
	var ravine_platform2 = get_parent().get_node("RavinePuzzle/UnlitOnlyPlatform2")
	var ravine_platform3 = get_parent().get_node("RavinePuzzle/UnlitOnlyPlatform3")
	var ravine_lever1 = get_parent().get_node("RavinePuzzle/Lever5")

	ravine_platform1.AllowPlatformSprites = true
	ravine_platform2.AllowPlatformSprites = true
	ravine_platform3.AllowPlatformSprites = true

	ravine_lever1.get_child(0).visible = state
	ravine_lever1.get_child(1).visible = state
	ravine_lever1.get_child(4).set_deferred("disabled", !state)

func Level2_Ravine_SecondLever(state):
	var ravine_lever2 = get_parent().get_node("RavinePuzzle/Lever5")
	
	for node in ravine_nodeArray:
		if ("Platform" in node.name):
			node.get_child(0).visible = state
			node.get_child(1).visible = state
			node.get_child(2).set_deferred("disabled", !state)
			if ("UnlitOnly" in node.name and state):
				node.FullEnablePlatform()
			elif ("UnlitOnly" in node.name):
				node.FullDisablePlatform()

	ravine_lever2.get_child(0).visible = state
	ravine_lever2.get_child(1).visible = state
	ravine_lever2.get_child(2).visible = state
	ravine_lever2.get_child(3).visible = state
	ravine_lever2.get_child(4).set_deferred("disabled", !state)

func Destroy_SkinnyBlockGate():
	if (!allowSkinnyBlockMovement):
		#Destroy skinnyBlockGate node from the scene
		skinnyBlockGate.queue_free()
		allowSkinnyBlockMovement = true

func Destroy_SmallBlockBlocker():
	if (!smallBlockFall):
		#Destroy smallBlockBlocker node from the scene
		smallBlockBlocker.queue_free()
		smallBlockFall = true

func Open_FinalDoor():
	#Final door motions downward
	finalDoor.OpenDoor()
	finalDoorOpened = true

func _on_EndLevel2_body_entered(body):
	if ("Milo" in body.name):
		if (GameManager.GetPlayer().GetHasStaffState()):
			if (GameManager.GetGemStates()["Blue"]):
				GameManager.ChangeScene()
