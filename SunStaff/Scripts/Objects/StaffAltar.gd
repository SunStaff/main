extends Area2D

var activated
var playerRootNode
var WithinAltarRange = false
onready var shader = self.material

# Sun Staff Variables
var SunStaff
var LightCircle
var CurrentClosestAltar
var minDistanceToAltar = INF
var HasStaff = true
var CurrentAltarWithStaff = null

# Called when the node enters the scene tree for the first time.
func _ready():
	playerRootNode = get_parent()
	SunStaff = GameManager.GetSunStaff()
	LightCircle = SunStaff.get_child(1)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	GlowMaterial(false)
	if (WithinAltarRange):
		GlowMaterial(true)
		if (Input.is_action_just_pressed("Interact")):
			if (GetCurrentClosestAltar(GameManager.GetSunStaffAltars(), GameManager.GetPlayer()) == self):
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
	if("Lever3" in area.name):
		area.SetObjectLightState(true)

func _on_LightCircle_area_exited(area):
	if ("Briar" in area.name):
		area.SetObjectLightState(false)
	if("Lever3" in area.name):
		area.SetObjectLightState(false)

func SunStaffPlacement():
	SunStaff = GameManager.GetSunStaff()
	LightCircle = SunStaff.get_child(1)
	if (GameManager.GetPlayer().GetHasStaffState() and !activated): # If Milo is holding staff
		SunStaff.get_child(0).set_color(Color(1,1,1,0))
		GameManager.GetPlayer().ChangeHasStaffState(false)
		CurrentClosestAltar.get_child(2).visible = true
		CheckForAltarMethodsOnLevels(true)
		activated = true
		CurrentAltarWithStaff = CurrentClosestAltar

	elif (CurrentAltarWithStaff == self): # If the altar has the Staff
		SunStaff.get_child(0).set_color(Color(1,1,1,1))
		GameManager.GetPlayer().ChangeHasStaffState(true)
		CurrentClosestAltar.get_child(2).visible = false
		CheckForAltarMethodsOnLevels(false)
		activated = false
		CurrentAltarWithStaff = null
	
	if (CurrentClosestAltar.get_child(2).visible): # If the altar has the Staff, turn off LightCircle monitoring
		LightCircle.ChangeLightCircleMonitoring(false)
	else:
		LightCircle.ChangeLightCircleMonitoring(true)

func GetCurrentClosestAltar(altars, player):
	CurrentClosestAltar = null
	# Get Current Closest Altar
	for altar in altars:
		var distanceTo = GameManager.DistanceTo(player.position, altar.global_position)
		if (distanceTo < minDistanceToAltar):
			minDistanceToAltar = distanceTo
			CurrentClosestAltar = altar
	minDistanceToAltar = INF
	return CurrentClosestAltar

func CheckForAltarMethodsOnLevels(state):
	GameManager.CheckForLevelSpecificActions("Altar",state,CurrentClosestAltar)

func GlowMaterial(state):
	if (state):
		shader.set_shader_param("color", Color(1,1,1,1.0))
	else:
		shader.set_shader_param("color", Color(1,1,1,0))
