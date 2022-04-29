extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Credits
var timer
onready var Player = $CenterContainer/AnimationPlayer
var LoadingScene

# Called when the node enters the scene tree for the first time.
func _ready():
	Credits = get_child(0).get_child(0)
	timer = Timer.new()
	self.add_child(timer)
	Player.current_animation = "Credits"
	Player.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (Input.is_action_just_pressed("Jump")):
		LoadingScene = preload("res://Scenes/Menus/LoadingScene.tscn").instance()
		self.add_child(LoadingScene)
		GameManager.ChangeScene()

func _on_AnimationPlayer_animation_finished(_anim_name):
	GameManager.ChangeScene()
