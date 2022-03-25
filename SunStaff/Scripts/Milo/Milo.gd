extends KinematicBody2D

# Node Variables
var playerRootNode
var sprite
var spriteUnlit

# Sun Staff Variables
var SunStaff
var LightCircle
var WithinAltarRange
var StaffAltars = []
var StaffVisibility
var CurrentClosestAltar
var minDistanceToAltar = INF
var HasStaff = true
var sprintcheck = false
# Lever Vairables
var WithinLeverRange
var CurrentClosestLever
var minDistanceToLever = INF
var Levers = []
var LeverObject

# Pedestal Variables
var WithinPedestalRange
var CurrentClosestPedestal
var minDistanceToPedestal = INF
var Pedestals = []
var PedestalName = ""
var GemObject

# Movement Variables
var faceRight = true
export (int) var speed = 300
export (int) var jump_speed = -1100
export (int) var gravity = 3000
export (float, 0, 1.0) var friction = 0.5
export (float, 0, 1.0) var acceleration = 0.25
var velocity = Vector2.ZERO
var justJumped = false


func _ready():
	playerRootNode = get_parent()
	sprite = $AnimatedSprite
	spriteUnlit = $AnimatedSprite2
	spriteUnlit.visible = false
	SunStaff = self.get_child(1).get_child(0) # Gets Sun Staff 
	LightCircle = get_child(1).get_child(0).get_child(1)
	
	WithinAltarRange = false
	StaffVisibility = true
	
	WithinPedestalRange = false
	WithinLeverRange = false

func get_input():
	if (GameManager.IsPlayerAlive and GameManager.IsGamePlaying):
		# Movement
		var dir = 0
		
		if Input.is_action_just_pressed("Jump"): 
			if is_on_floor():
				velocity.y = jump_speed
				if (HasStaff):
					sprite.animation = "MiloJumpFallStaff"
					spriteUnlit.visible = false
				else:
					spriteUnlit.visible = true
					sprite.animation = "MiloJumpFallStaffless"
					spriteUnlit.animation = "MiloJumpFallUNLIT"
		
		elif Input.is_action_just_pressed("Right"):
			if (!faceRight):
				sprite.scale.x *= -1
				spriteUnlit.scale.x *= -1
				faceRight = true
			if (HasStaff):
				sprite.animation = "MiloWalkStaff"
				spriteUnlit.visible = false
			else:
				spriteUnlit.visible = true
				sprite.animation = "MiloWalkStaffless"
				spriteUnlit.animation = "MiloWalkStafflessUNLIT"
		
		elif Input.is_action_just_pressed("Left"):
			if (faceRight):
				sprite.scale.x *= -1
				spriteUnlit.scale.x *= -1
				faceRight = false
			if (HasStaff):
				sprite.animation = "MiloWalkStaff"
				spriteUnlit.visible = false
			else:
				spriteUnlit.visible = true
				sprite.animation = "MiloWalkStaffless"
				spriteUnlit.animation = "MiloWalkStafflessUNLIT"

		if Input.is_action_pressed("Right"):
			if sprintcheck == true:
				dir += 2
			else:
				dir += 1
				
			if (justJumped):
				if (HasStaff):
					spriteUnlit.visible = false
					sprite.animation = "MiloWalkStaff"
				else:
					spriteUnlit.visible = true
					sprite.animation = "MiloWalkStaffless"
					spriteUnlit.animation = "MiloWalkStafflessUNLIT"
				justJumped = false
		
		elif Input.is_action_pressed("Left"):
			if sprintcheck == true:
				dir -= 2
			else:
				dir -= 1
			if (justJumped):
				if (HasStaff):
					spriteUnlit.visible = false
					sprite.animation = "MiloWalkStaff"
				else:
					spriteUnlit.visible = true
					sprite.animation = "MiloWalkStaffless"
					spriteUnlit.animation = "MiloWalkStafflessUNLIT"
				justJumped = false
		
		else:
			if (HasStaff):
				
					spriteUnlit.visible = false
					sprite.animation = "MiloIdleStaff"
			else:
				
					spriteUnlit.visible = true
					sprite.animation = "MiloIdleStaffless"
					spriteUnlit.animation = "MiloIdleStafflessUNLIT"
		if Input.is_action_pressed("sprint"):
			sprintcheck = true
			if (HasStaff):
				spriteUnlit.visible = false
				sprite.animation = "MiloRunStaff"
			else:
				spriteUnlit.visible = true
				sprite.animation = "MiloRunStaffless"
				spriteUnlit.animation = "MiloRunStafflessUNLIT"
		else:
			sprintcheck = false
		if dir != 0:
			velocity.x = lerp(velocity.x, dir * speed, acceleration)
		else:
			velocity.x = lerp(velocity.x, 0, friction)

		# Sun Staff Placement
		if (WithinAltarRange):
			if (Input.is_action_just_pressed("Interact")):
				SunStaffPlacement()

		# Gem Pedestal Placement
		elif (WithinPedestalRange):
			if (Input.is_action_just_pressed("Interact")):
				GemPlacement()
		
		# Gem Pickup
		elif (GemObject != null):
			if (Input.is_action_just_pressed("Interact")):
				GemPickup()
		
		# Lever Toggling
		elif (WithinLeverRange):
			if (Input.is_action_just_pressed("Interact")):
				FlipLever()

		# If Player is Falling Passed Border
		if (self.position.y > 900):
			GameManager.SetPlayerAliveState(false)
	else:
		velocity = Vector2.ZERO
	
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
		
func PlayerDeath(position):
	self.position = position
	velocity.x = 0
	velocity.y = 0
	WithinAltarRange = false
	WithinLeverRange = false
	WithinPedestalRange = false

func _on_InteractRange_area_entered(area:Area2D):
	if ("StaffAltar" in area.name):
		WithinAltarRange = true
		GetCurrentClosestAltar()

	if ("Lever" in area.name):
		WithinLeverRange = true
		LeverObject = area
		GetCurrentClosestLever()

	if ("GemPedestal" in area.name):
		WithinPedestalRange = true
		GetCurrentClosestPedestal()

	if ("GemPickup" in area.name):
		GemObject = area

func _on_InteractRange_area_exited(area:Area2D):
	if ("StaffAltar" in area.name):
		WithinAltarRange = false
		GetCurrentClosestAltar()

	if ("Lever" in area.name):
		WithinLeverRange = false
		LeverObject = null
		GetCurrentClosestLever()

	if ("GemPedestal" in area.name):
		WithinPedestalRange = false
		GetCurrentClosestPedestal()

func SunStaffPlacement():
	GetCurrentClosestAltar()
	if (StaffVisibility): # If Milo is holding staff
		SunStaff.get_child(0).set_color(Color(1,1,1,0))
		StaffVisibility = false
		HasStaff = false
		CurrentClosestAltar.visible = true
		GameManager.CheckForLevelSpecificActions("Altar",true,CurrentClosestAltar)
		GameManager.CheckForLevelSpecificActions("Altar",true,CurrentClosestAltar)

	else: # If the altar has the Staff
		SunStaff.get_child(0).set_color(Color(1,1,1,1))
		StaffVisibility = true
		HasStaff = true
		CurrentClosestAltar.visible = false
		GameManager.CheckForLevelSpecificActions("Altar",false,CurrentClosestAltar)
		GameManager.CheckForLevelSpecificActions("Altar",false,CurrentClosestAltar)
	
	if (CurrentClosestAltar.visible): # If the altar has the Staff, turn off LightCircle monitoring
		LightCircle.monitoring = false
	else:
		LightCircle.monitoring = true
	GetCurrentClosestAltar()

func GemPlacement():
	GetCurrentClosestPedestal()
	GameManager.OpenGemSelectionScreen(CurrentClosestPedestal)

func GemPickup():
	var color = GemObject.name.replacen("_GemPickup", "")
	GameManager.ToggleGem(color)
	GemObject.visible = false

func FlipLever():
	LeverObject._change_lever_state()

func DistanceTo(a,b):
	var x = a.x - b.x
	var y = a.y - b.y
	return sqrt(pow(x,2) + pow(y,2))
	
func _on_AnimatedSprite_animation_finished(): 
	if ("MiloJumpFallStaff" in sprite.animation):
		justJumped = true

func GetCurrentClosestAltar():
	StaffAltars.clear()
	for altar in GameManager.GetSunStaffAltars():
		StaffAltars.append(altar.get_child(1).get_child(0))
	# Get Current Closest Altar
	for altar in StaffAltars:
		var distanceTo = DistanceTo(self.position, altar.get_parent().get_parent().position)
		if (distanceTo < minDistanceToAltar):
			minDistanceToAltar = distanceTo
			CurrentClosestAltar = altar
	minDistanceToAltar = INF

func GetCurrentClosestLever():
	Levers.clear()
	for lever in GameManager.GetLevers():
		Levers.append(lever)
	# Get Current Closest Lever
	for lever in Levers:
		var distanceTo = DistanceTo(self.position, lever.position)
		if (distanceTo < minDistanceToLever):
			minDistanceToLever = distanceTo
			CurrentClosestLever = lever
			LeverObject = CurrentClosestLever
	minDistanceToLever = INF

func GetCurrentClosestPedestal():
	Pedestals.clear()
	for pedestal in GameManager.GetGemPedestals():
		Pedestals.append(pedestal)
	# Get Current Closest Pedestal
	for pedestal in Pedestals:
		var distanceTo = DistanceTo(pedestal.position, self.position)
		if (distanceTo < minDistanceToPedestal):
			minDistanceToPedestal = distanceTo
			CurrentClosestPedestal = pedestal
	minDistanceToPedestal = INF
