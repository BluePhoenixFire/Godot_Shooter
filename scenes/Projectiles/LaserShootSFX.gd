extends AudioStreamPlayer2D

var random_generator = RandomNumberGenerator.new()

func _ready():
	pitch_scale = random_generator.randf_range(0.8,1.2)
