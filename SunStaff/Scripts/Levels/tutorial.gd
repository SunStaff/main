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

func _ready():
	door2 = get_parent().get_node("Section2/Door2")
	StaffAltar_Grand = get_parent().get_node("StaffAltar_Grand")
	StaffAltar_Puzzle=  get_parent().get_node("Section2/StaffAltar")
	lever2 = get_parent().get_node("Section2/Lever2")
	Milo = GameManager.GetPlayer()

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
