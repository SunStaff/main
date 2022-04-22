extends CanvasLayer

var Video
var activated = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Video = get_child(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (int(Video.stream_position) == 27 and !activated):
		GameManager.ChangeScene()
		activated = true

	if (Input.is_action_just_pressed("Jump")):
		GameManager.ChangeScene()
