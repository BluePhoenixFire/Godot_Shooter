# AudioManager.gd
extends Node

# This node can be used for background music that persists across scenes.
@onready var music_player: AudioStreamPlayer = $MusicPlayer
var music: AudioStream = preload("res://audio/Echoes-of-Time-v2(chosic.com).mp3")

func _ready():
	if not music_player.playing:
		play_music(music)

# Function to play background music
func play_music(stream: AudioStream):
	music_player.stream = stream
	if not music_player.playing:
		music_player.play()

# Function to stop the music
func stop_music():
	if music_player.playing:
		music_player.stop()

# Function to play sound effects
func play_sfx(stream: AudioStream, volume_db: float = 0.0, position: Vector2 = Vector2()):
	var sfx_player = AudioStreamPlayer2D.new()
	sfx_player.stream = stream
	sfx_player.volume_db = volume_db
	# If you want the sound to come from a particular position
	if position != Vector2():
		sfx_player.global_position = position
	add_child(sfx_player)
	sfx_player.play()
	await sfx_player.finished
	sfx_player.queue_free()

