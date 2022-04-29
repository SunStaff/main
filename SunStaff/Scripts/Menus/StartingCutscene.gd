extends CanvasLayer

var Video
var activated = false
var LoadingScene
# Called when the node enters the scene tree for the first time.
func _ready():
	Video = get_child(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (int(Video.stream_position) == 54 and !activated):
		GameManager.ChangeScene("Tutorial")
		activated = true

	if (Input.is_action_just_pressed("Jump")):
		LoadingScene = preload("res://Scenes/Menus/LoadingScene.tscn").instance()
		self.add_child(LoadingScene)
		GameManager.ChangeScene("Tutorial")
