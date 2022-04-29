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
onready var FrustratedMew = $FrustratedMew
onready var Mew = $Mew
onready var HappyNoise = $HappyNoise

var LitMusicCurrentPos = 0.0
var UnlitMusicCurrentPos = 0.0
var MewArray = ["res://Art/Sounds/mew.v1.ilcapand.wav","res://Art/Sounds/mew.v2.ilcapand.wav","res://Art/Sounds/mew.v3.ilcapand.wav"]

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
	if (not Bell.playing):
		Bell.play(0)

func PlayCollectable():
	if (not Collectable.playing):
		Collectable.play(0)

func PlayLanding():
	if (not Landing.playing):
		Landing.play(0)

func PlayLitAmbience():
	if (not LitAmbience.playing):
		LitAmbience.play(0)

func PlayUnlitAmbience():
	if (not UnlitAmbience.playing):
		UnlitAmbience.play(0)

func PlayFrustratedMew():
	if (not FrustratedMew.playing):
		FrustratedMew.play(0)

func PlayHappyNoise():
	if (not HappyNoise.playing):
		HappyNoise.play(0)

func PlayMew():
	if (not Mew.playing):
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var randomMew = load(MewArray[rng.randi_range(0,len(MewArray)-1)])
		Mew.stream = randomMew
		Mew.play(0)

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

func StopMew():
	Mew.stop()

func ChangeBetweenLitAndUnlit(HasStaff):
	if (HasStaff):
		StopUnlitAmbience()
		StopUnlitMusic()
		PlayLitAmbience()
		PlayLitMusic()
		
	else:
		StopLitAmbience()
		StopLitMusic()
		PlayUnlitAmbience()
		PlayUnlitMusic()
