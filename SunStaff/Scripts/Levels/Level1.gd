extends Node

#For lever platform-staircase puzzle
var movingAltar
var movingPlatform
var movingBlock
var drawBridge

var checkPoint1 = true;
var checkPoint2 = false;
var checkPoint3 = false;

const POS1 = 2864
const POS2 = 5714
const POS3 = 9514

# Called when the node enters the scene tree for the first time.
func _ready():
    movingAltar = get_parent().get_node("MovingAltar")
    movingPlatform = get_parent().get_node("MovingPlatform")
    movingBlock = get_parent().get_node("MovingBlock")
    drawBridge = get_parent().get_node("DrawBridge")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func ChangeAltarPos():
    if(checkPoint1):
        while(movingAltar.position.x <= POS2 and movingPlatform.position.x <= POS2):
            movingAltar.position.x += 50
            movingPlatform.position.x += 50
        checkPoint1 = false
        checkPoint2 = true
    if(checkPoint2):
        while(movingAltar.position.x <= POS3 and movingPlatform.position.x <= POS3):
            movingAltar.position += 50
        checkPoint2 = false
        checkPoint3 = true

func MoveBlock():
    while(movingBlock.position.y <= 1000):
        movingBlock.position.x += 50

func ReleaseDrawBridge():

    while(drawBridge.rotation <= 90):
        drawBridge.rotation += 1 