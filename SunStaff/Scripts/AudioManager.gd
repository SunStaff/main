extends Node2D

onready var LitMusic = $LitMusic
onready var UnlitMusic = $UnlitMusic
onready var Walking = $Walking
onready var Running = $Running
onready var Bell = $Bell
onready var Collectable = $Collectable
onready var Landing = $Landing
onready var LitAmbience = $LitAmbience
onready var UnlitAmbience = $UnlitAmbience

var LitMusicCurrentPos = 0.0
var UnlitMusicCurrentPos = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func PlayLitMusic():
	if (LitMusicCurrentPos > LitMusic.stream.get_length() - 5):
		LitMusicCurrentPos = 0.0
	if (not LitMusic.playing):
		LitMusic.play(LitMusicCurrentPos)

func PlayUnlitMusic():
	if (UnlitMusicCurrentPos > UnlitMusic.stream.get_length() - 5):
		UnlitMusicCurrentPos = 0.0
	if (not UnlitMusic.playing):
		UnlitMusic.play(UnlitMusicCurrentPos)

func PlayWalking():
	if (not Walking.playing):
		Walking.play(0)

func PlayRunning():
	if (not Running.playing):
		Running.play(0)

func PlayBell():
	Bell.play(0)

func PlayCollectable():
	Collectable.play(0)

func PlayLanding():
	Landing.play(0)

func PlayLitAmbience():
	if (not LitAmbience.playing):
		LitAmbience.play(0)

func PlayUnlitAmbience():
	if (not UnlitAmbience.playing):
		UnlitAmbience.play(0)

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

func StopLitAmbience():
	LitAmbience.stop()

func StopUnlitAmbience():
	UnlitAmbience.stop()

func _on_LitAmbience_finished():
	LitAmbience.play(0.0)

func _on_UnlitAmbience_finished():
	UnlitAmbience.play(0.0)

func ChangeBetweenLitAndUnlit(HasStaff):
	if (HasStaff):
		AudioManager.StopUnlitAmbience()
		AudioManager.StopUnlitMusic()
		AudioManager.PlayLitAmbience()
		AudioManager.PlayLitMusic()
		
	else:
		AudioManager.StopLitAmbience()
		AudioManager.StopLitMusic()
		AudioManager.PlayUnlitAmbience()
		AudioManager.PlayUnlitMusic()
