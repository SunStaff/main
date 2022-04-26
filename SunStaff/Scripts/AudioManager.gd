extends Node2D

onready var LitMusic = $LitMusic
onready var UnlitMusic = $UnlitMusic
onready var Walking = $Walking
onready var Running = $Running
onready var Bell = $Bell
onready var Collectable = $Collectable
onready var Landing = $Landing
onready var LitAmbience = $LitAmbience

var LitMusicCurrentPos = 0.0
var UnlitMusicCurrentPos = 0.0
var currentLitAmbienceIndex = 0
var AmbienceLitSounds = ["res://Art/Sounds/Fairy Forest.wav", "res://Art/Sounds/Fairy Forest.v2.ilcapand.wav", "res://Art/Sounds/Fairy Forest.v3.ilcapand.wav"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func PlayLitMusic():
	if (LitMusicCurrentPos > LitMusic.stream.get_length() - 5):
		LitMusicCurrentPos = 0.0
	LitMusic.play(LitMusicCurrentPos)

func PlayUnlitMusic():
	if (UnlitMusicCurrentPos > UnlitMusic.stream.get_length() - 5):
		UnlitMusicCurrentPos = 0.0
	UnlitMusic.play(UnlitMusicCurrentPos)

func PlayWalking():
	Walking.play(0)

func PlayRunning():
	Running.play(0)

func PlayBell():
	Bell.play(0)

func PlayCollectable():
	Collectable.play(0)

func PlayLanding():
	Landing.play(0)

func StopLitMusic():
	LitMusicCurrentPos = LitMusic.get_playback_position()
	LitMusic.stop()

func StopUnlitMusic():
	UnlitMusicCurrentPos = UnlitMusic.get_playback_position()
	UnlitMusic.stop()

func StopWalking():
	Walking.stop()

func StopRunning():
	Running.stop()

func StopBell():
	Bell.stop()

func StopCollectable():
	Collectable.stop()

func StopLanding():
	Landing.stop()
