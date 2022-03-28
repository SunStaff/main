extends Area2D

var activated
var playerRootNode
var WithinAltarRange = false

# Sun Staff Variables
var SunStaff
var LightCircle
var StaffAltars = []
var StaffVisibility
var CurrentClosestAltar
var minDistanceToAltar = INF
var HasStaff = true

# Called when the node enters the scene tree for the first time.
func _ready():
	playerRootNode = get_parent()
	SunStaff = GameManager.GetSunStaff()
	LightCircle = SunStaff.get_child(1)
	StaffVisibility = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (WithinAltarRange):
		if (Input.is_action_just_pressed("Interact")):
			if (GetCurrentClosestAltar() == self):
				SunStaffPlacement()

func _on_StaffAltar_body_entered(body):
	if ("Milo" in body.name):
		WithinAltarRange = true

func _on_StaffAltar_body_exited(body):
	if ("Milo" in body.name):
		WithinAltarRange = false

func _on_LightCircle_area_entered(area):
	if ("Briar" in area.name):
		area.SetObjectLightState(true)

func _on_LightCircle_area_exited(area):
	if ("Briar" in area.name):
		area.SetObjectLightState(false)

func SunStaffPlacement():
	GetCurrentClosestAltar()
	if (StaffVisibility): # If Milo is holding staff
		SunStaff.get_child(0).set_color(Color(1,1,1,0))
		print(SunStaff.get_child(0))
		StaffVisibility = false
		GameManager.GetPlayer().ChangeHasStaffState(false)
		CurrentClosestAltar.get_child(1).get_child(0).visible = true
		GameManager.CheckForLevelSpecificActions("Altar",true,CurrentClosestAltar)
		GameManager.CheckForLevelSpecificActions("Altar",true,CurrentClosestAltar)

	else: # If the altar has the Staff
		SunStaff.get_child(0).set_color(Color(1,1,1,1))
		StaffVisibility = true
		GameManager.GetPlayer().ChangeHasStaffState(true)
		CurrentClosestAltar.get_child(1).get_child(0).visible = false
		GameManager.CheckForLevelSpecificActions("Altar",false,CurrentClosestAltar)
		GameManager.CheckForLevelSpecificActions("Altar",false,CurrentClosestAltar)
	
	if (CurrentClosestAltar.visible): # If the altar has the Staff, turn off LightCircle monitoring
		LightCircle.ChangeLightCircleMonitoring(false)
	else:
		LightCircle.ChangeLightCircleMonitoring(true)

func GetCurrentClosestAltar():
	StaffAltars.clear()
	for altar in GameManager.GetSunStaffAltars():
		StaffAltars.append(altar)
	# Get Current Closest Altar
	for altar in StaffAltars:
		var distanceTo = GameManager.DistanceTo(GameManager.GetPlayer().position, altar.position)
		if (distanceTo < minDistanceToAltar):
			minDistanceToAltar = distanceTo
			CurrentClosestAltar = altar
	minDistanceToAltar = INF
	return CurrentClosestAltar