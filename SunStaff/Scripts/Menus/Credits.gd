extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Credits
var timer

# Called when the node enters the scene tree for the first time.
func _ready():
	Credits = get_child(0).get_child(0)
	timer = Timer.new()
	self.add_child(timer)
	MoveCredits()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (Input.is_action_just_pressed("Jump")):
		GameManager.ChangeScene()

func MoveCredits():
	while (Credits.rect_position.y > -5300):
		Credits.rect_position.y = lerp(Credits.rect_position.y, Credits.rect_position.y-50, 0.5)
		timer.set_wait_time(0.3)
		timer.set_one_shot(true)
		timer.start()
		yield(timer, "timeout")
	timer.set_wait_time(5)
	timer.set_one_shot(true)
	timer.start()
	yield(timer, "timeout")
	GameManager.ChangeScene()
