extends Node


var tutorial_door1
var tutorial_door2
var StaffAltar
var SunStaff
var Altar_holding_staff
var timer
var StaffAltars = []
var lever2

func _ready():
	tutorial_door2 = get_parent().get_node("next_pedestal_to_end/door_endingdoor")
	StaffAltar = get_parent().get_node("sun_staff_resting_place/StaffAltar resting place")
	Altar_holding_staff =  get_parent().get_node("next_pedestal_to_end/staff_tutorial")
	lever2 = get_parent().get_node("next_pedestal_to_end/Lever2")
	if !Altar_holding_staff.activated:
		print("staff alter is not activated")
	elif Altar_holding_staff.activated:
		print("staff alter is activated")
	



func _physics_process(delta):
	
	if Altar_holding_staff.activated:
		print("staff alter is activated")
		tutorial_door2.position.y = 780
	elif !Altar_holding_staff.activated and !lever2.isTurnedOn:
		print("staff alter is not activated")
		tutorial_door2.position.y = 280


func _on_EndLevelT_body_entered(body):
		if ("Milo" in body.name):
			GameManager.ChangeScene()
