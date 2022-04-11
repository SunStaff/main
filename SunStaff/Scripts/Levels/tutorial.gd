extends Node


var tutorial_door1
var tutorial_door2
var staffAltar
var Alter_holding_staff
var timer

func _ready():
	tutorial_door1 = get_parent().get_node("lever and briar section/StartingDoor")
	tutorial_door2 = get_parent().get_node("next pedestal to end/ending door")

func Tutorial_MoveDoor_DueTo_lever1(open):
	if (open):
		while (tutorial_door1.position.y < 1000):
			tutorial_door1.position.y += 50
			timer.set_wait_time(0.1)
			timer.set_one_shot(true)
			timer.start()
			yield(timer, "timeout")

func Tutorial_MoveDoor_DueTo_lever2(open):
	if (open):
		while (tutorial_door2.position.y < 1000):
			tutorial_door2.position.y += 50
			timer.set_wait_time(0.1)
			timer.set_one_shot(true)
			timer.start()
			yield(timer, "timeout")
