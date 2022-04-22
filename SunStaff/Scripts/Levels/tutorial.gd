extends Node

var door2
var StaffAltar_Puzzle
var StaffAltar_Grand
var StaffAltars = []
var lever2
var Milo
var platform1
var platform2
var activated = false
var SunStaff
var TutorialMessages
var lrActivated = false
var jActivated = false
var iActivated = false
var sActivated = false
var pActivated = false

func _ready():
	door2 = get_parent().get_node("Section2/Door2")
	StaffAltar_Grand = get_parent().get_node("StaffAltar_Grand")
	StaffAltar_Puzzle=  get_parent().get_node("Section2/StaffAltar")
	lever2 = get_parent().get_node("Section2/Lever2")
	Milo = GameManager.GetPlayer()
	CreateTutorialMessages()
	platform1 = get_parent().get_node("Platform")
	platform1.get_child(2).set_deferred("disabled", true)
	platform1.get_child(1).set_deferred("visible", false)
	platform2 = get_parent().get_node("Platform2")
	platform2.get_child(2).set_deferred("disabled", true)
	platform2.get_child(1).set_deferred("visible", false)

	StaffAltar_Grand.CurrentAltarWithStaff = StaffAltar_Grand
	StaffAltar_Grand.activated = true
	SunStaff = GameManager.GetSunStaff()
	SunStaff.get_child(0).set_color(Color(1,1,1,0))
	GameManager.GetPlayer().ChangeHasStaffState(false)
	SunStaff.get_child(1).ChangeLightCircleMonitoring(false)

func _physics_process(_delta):
	CheckMiloPosition()
	GrandStaff()
	# If the Staff is in the altar, open the door
	if StaffAltar_Puzzle.activated:
		door2.OpenDoor()
	# If the staff is not in the altar and the lever is not turned on, close the door
	elif !StaffAltar_Puzzle.activated and !lever2.isTurnedOn:
		door2.CloseDoor()

func GrandStaff():
	# If the Grand Staff Altar doesn't have the staff, execute
	if (!StaffAltar_Grand.activated and !activated):
		activated = true
			
		platform1.get_child(2).set_deferred("disabled", false)
		platform1.get_child(1).set_deferred("visible", true)
		platform2.get_child(2).set_deferred("disabled", false)
		platform2.get_child(1).set_deferred("visible", true)

func _on_EndTutorial_body_entered(body):
	if ("Milo" in body.name):
		GameManager.ChangeScene()

func CreateTutorialMessages():
	TutorialMessages = load("res://Scenes/Milo/TutorialMessages.tscn").instance()
	Milo.add_child(TutorialMessages)
	TutorialMessages.position.y = -440
	TutorialMessages.visible = false

func DisplayLR():
	TutorialMessages.visible = true
	TutorialMessages.frame = 0

func DisplayJump():
	TutorialMessages.visible = true
	TutorialMessages.frame = 1

func DisplayInteract():
	TutorialMessages.visible = true
	TutorialMessages.frame = 3

func DisplayRun():
	TutorialMessages.visible = true
	TutorialMessages.frame = 2

func DisplayPause():
	TutorialMessages.visible = true
	TutorialMessages.frame = 4

func TurnOffMessage():
	TutorialMessages.visible = true

func CheckMiloPosition():
	if(Milo.position.x > -441 and Milo.position.x < 260):
		DisplayLR()
	elif (Milo.position.x > 300 and Milo.position.x < 916):
		DisplayJump()
	elif (Milo.position.x > 1920 and Milo.position.x < 2650):
		DisplayInteract()
	elif (Milo.position.x > 3955 and Milo.position.x < 4776):
		DisplayInteract()
	elif (Milo.position.x > 4826 and Milo.position.x < 6110):
		DisplayPause()
	elif (Milo.position.x > 6540 and Milo.position.x < 7755):
		DisplayRun()
	elif (Milo.position.x > 8438 and Milo.position.x < 8900):
		DisplayInteract()
	elif (Milo.position.x > 9800 and Milo.position.x < 10400):
		DisplayInteract()
	else:
		TurnOffMessage()
