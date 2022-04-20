extends Node


var tutorial_door1
var tutorial_door2
var StaffAltartest
var SunStaff
var Altar_holding_staff
var timer
var StaffAltars = []
var lever2
var milo

func _ready():
	tutorial_door2 = get_parent().get_node("next_pedestal_to_end/door_endingdoor")
	Altar_holding_staff = get_parent().get_node("sun_staff_resting_place/StaffAltar resting place")
	StaffAltartest =  get_parent().get_node("next_pedestal_to_end/staff_tutorial")
	lever2 = get_parent().get_node("next_pedestal_to_end/Lever2")
	milo = get_parent().get_node("Milo")
	milo.HasStaff = false
	milo.TurnLightOff = true
	Altar_holding_staff.CurrentAltarWithStaff = Altar_holding_staff



func _physics_process(delta):
	
	if StaffAltartest.activated:
		tutorial_door2.position.y = 780
	elif !StaffAltartest.activated and !lever2.isTurnedOn:
		tutorial_door2.position.y = 280


func _on_EndLevelT_body_entered(body):
		if ("Milo" in body.name):
			GameManager.ChangeScene()
