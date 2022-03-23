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
var currentClosestAltar
var minDistanceToAltar = INF
var HasStaff = true
var sprintcheck = false
# Lever Vairables
var WithinLeverRange

# Pedestal Variables
var WithinPedestalRange
var currentClosestPedestal
var minDistanceToPedestal = INF
var Pedestals = []
var PedestalName = ""
var GemObject

# Movement Variables
var faceRight = true
export (int) var speed = 300
export (int) var jump_speed = -1100
export (int) var gravity = 3000
export (float, 0, 1.0) var friction = 0.2
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
	var staffAltarObjects = GameManager.GetSunStaffAltars()
	for altar in staffAltarObjects:
		StaffAltars.append(altar.get_child(1).get_child(0))
	
	WithinPedestalRange = false
	WithinLeverRange = false
	var pedestalObjects = GameManager.GetGemPedestals()
	for pedestal in pedestalObjects:
		Pedestals.append(pedestal)

func get_input():
	if (GameManager.IsPlayerAlive and GameManager.IsGamePlaying):
		# Movement
		var dir = 0
		if Input.is_action_pressed("sprint"):
			sprintcheck = true
		else:
			sprintcheck = false
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
		
		if dir != 0:
			velocity.x = lerp(velocity.x, dir * speed, acceleration)
		else:
			velocity.x = lerp(velocity.x, 0, friction)

		# Sun Staff Placement
		if (WithinAltarRange):
			if (Input.is_action_just_pressed("Interact")):
				SunStaffPlacement()

		# Gem Pedestal Placement
		if (WithinPedestalRange):
			if (Input.is_action_just_pressed("Interact")):
				GemPlacement()
		
		# Gem Pickup
		if (GemObject != null):
			if (Input.is_action_just_pressed("Interact")):
				GemPickup()
		
		# Lever Toggling

		# If Player is Falling Passed Border
		if (self.position.y > 900):
			GameManager.SetPlayerAliveState(false)
	else:
		velocity = Vector2.ZERO
	
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# Get Current Closest Altar
	for altar in StaffAltars:
		var distanceTo = DistanceTo(self.position, altar.position)
		if (distanceTo < minDistanceToAltar):
			minDistanceToAltar = distanceTo
			currentClosestAltar = altar

	# Get Current Closest Pedestal
	for pedestal in Pedestals:
		var distanceTo = DistanceTo(self.position, pedestal.position)
		if (distanceTo < minDistanceToPedestal):
			minDistanceToPedestal = distanceTo
			currentClosestPedestal = pedestal
		
func PlayerDeath(position):
	self.position = position
	# SunStaff.get_child(0).set_color(Color(1,1,1,1))
	# currentClosestAltar.set_deferred("visible", false)
	# LightCircle.set_deferred("monitoring", true)
	WithinAltarRange = false
	WithinLeverRange = false
	WithinPedestalRange = false

func _on_InteractRange_area_entered(area:Area2D):
	if ("StaffAltar" in area.name):
		WithinAltarRange = true
	if ("Lever" in area.name):
		pass
	if ("GemPedestal" in area.name):
		WithinPedestalRange = true
	if ("GemPickup" in area.name):
		GemObject = area

func _on_InteractRange_area_exited(area:Area2D):
	if ("StaffAltar" in area.name):
		WithinAltarRange = false
	if ("Lever" in area.name):
		pass
	if ("GemPedestal" in area.name):
		WithinPedestalRange = false

func SunStaffPlacement():
	if (StaffVisibility): # If Milo is holding staff
		SunStaff.get_child(0).set_color(Color(1,1,1,0))
		StaffVisibility = false
		HasStaff = false
		currentClosestAltar.visible = true
	else: # If the altar has the Staff
		SunStaff.get_child(0).set_color(Color(1,1,1,1))
		StaffVisibility = true
		HasStaff = true
		currentClosestAltar.visible = false
	if (currentClosestAltar.visible): # If the altar has the Staff, turn off LightCircle monitoring
		LightCircle.monitoring = false
	else:
		LightCircle.monitoring = true

func GemPlacement():
	GameManager.OpenGemSelectionScreen(currentClosestPedestal)

func GemPickup():
	var color = GemObject.name.replacen("_GemPickup", "")
	GameManager.ToggleGem(color)
	GemObject.visible = false

func DistanceTo(a,b):
	return sqrt(pow((b.x - a.x),2) + pow((b.y - a.y),2))
	
func _on_AnimatedSprite_animation_finished(): 
	if ("MiloJumpFallStaff" in sprite.animation):
		justJumped = true
