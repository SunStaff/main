extends Node

#For lever platform-staircase puzzle
var movingAltar
var movingPlatform
var movingBlock
var drawBridge

var checkPoint1 = true;
var checkPoint2 = false;
var checkPoint3 = false;

var timer

#Get all puzzle platforms for a level 1 puzzle
var Platforms = []
var platform1
var platform2
var platform3

# Called when the node enters the scene tree for the first time.
func _ready():
	movingAltar = get_parent().get_node("MovingAltar")
	movingPlatform = get_parent().get_node("MovingPlatform")
	movingBlock = get_parent().get_node("MovingBlock")
	drawBridge = get_parent().get_node("DrawBridge")

	Platforms.clear()
	#Gets Puzzle Platforms within the level
	Platforms = get_tree().get_nodes_in_group("Platform")
	platform1 = Platforms[0]
	platform2 = Platforms[1]
	platform3 = Platforms[2]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func ChangeAltarPos(POS, goingRight):
	if(goingRight):
		while (movingAltar.position.x < POS):
			movingAltar.position.x = lerp(movingAltar.position.x,movingAltar.position.x+50,0.5)
			movingPlatform.position.x = lerp(movingPlatform.position.x,movingPlatform.position.x+50,0.5)
			yield(get_tree().create_timer(.05), "timeout")
	else:
		while (movingAltar.position.x > POS):
			movingAltar.position.x = lerp(movingAltar.position.x,movingAltar.position.x-50,0.5)
			movingPlatform.position.x = lerp(movingPlatform.position.x,movingPlatform.position.x-50,0.5)
			yield(get_tree().create_timer(.05), "timeout")

func MoveBlock():
	while(movingBlock.position.y <= 5000):
		movingBlock.position.y += 50

func ReleaseDrawBridge():
	if(drawBridge.rotation_degrees <= 0):
		while(drawBridge.rotation_degrees <= 90):
			drawBridge.rotation_degrees += 1 
	elif(drawBridge.rotation_degrees >= 90):
		while(drawBridge.rotation_degrees >= 0):
			drawBridge.rotation_degrees -= 1 

func SetAltarCheckPoint(num):
	if(num == 1):
		checkPoint1 = true
		checkPoint2 = false
		checkPoint3 = false
	elif (num == 2):
		checkPoint1 = false
		checkPoint2 = true
		checkPoint3 = false
	elif (num == 3):
		checkPoint1 = false
		checkPoint2 = false
		checkPoint3 = true


func _on_EndLevel1_body_entered(body):
	if ("Milo" in body.name):
		if (GameManager.GetPlayer().GetHasStaffState()):
			if (GameManager.GetGemStates()["Green"]):
				Level1End()

func Level1End():
	GameManager.ChangeScene("Level2")

#num * -INCREMENT determines puzzle platform's y-pos (tells current num for current position)
#Current numbers are the defaults
var num1 = 6
var num2 = 0
var num3 = 3
#tells the newNum for its new position [Lerping causes inputs to be eaten depending on timing]
# var newNum1 = 0
# var newNum2 = 0
# var newNum3 = 0
#increment at which platforms move when num is increased by 1.
const INCREMENT = 200
#Lowest possible y-pos for puzzle platforms
const PLATFORM_OFFSET = -269

func FlippedPuzzleLever(leverNum):
	if(leverNum == 1):
		num1 = (num1 + 1) % 10
		num3 = (num3 + 1) % 10
		platform1.position.y = num1 * (-INCREMENT) + PLATFORM_OFFSET
		platform3.position.y = num3 * (-INCREMENT) + PLATFORM_OFFSET
	elif(leverNum == 2):
		num1 = (num1 + 1) % 10
		num2 = (num2 + 1) % 10
		platform1.position.y = num1 * (-INCREMENT) + PLATFORM_OFFSET
		platform2.position.y = num2 * (-INCREMENT) + PLATFORM_OFFSET
	elif(leverNum == 3):
		num2 = (num2 + 3) % 10
		num3 = (num3 + 3) % 10
		platform2.position.y = num2 * (-INCREMENT) + PLATFORM_OFFSET
		platform3.position.y = num3 * (-INCREMENT) + PLATFORM_OFFSET
		

func OffsetCamera():
	GameManager.OffsetCameraMilo(2000)

func OriginalCamera():
	GameManager.OffsetCameraMilo(0)
