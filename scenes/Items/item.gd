#Item
extends Area2D

var rotation_speed: int = 2
var available_types = [ 'health','laser','laser','laser','laser', 'grenade',]
var state = available_types[randi() % len(available_types)]
var laser_colour: Color = Color(0.1, 0.2, 0.8)
var grenade_colour: Color = Color(0.8, 0.2, 0.1)
var health_colour: Color = Color(0.1, 0.2, 0.1)
var item_sfx: AudioStream = preload("res://audio/item.mp3")

@onready var tween: Tween

func _ready():
	match state:
		"laser":
			$Sprite2D.modulate = laser_colour
			$PointLight2D.color = laser_colour
		"grenade":
			$Sprite2D.modulate = grenade_colour
			$PointLight2D.color = grenade_colour
		"health":
			$Sprite2D.modulate = health_colour
			$PointLight2D.color = health_colour
			
	scale_adjuster()

func _process(delta):
	rotation += rotation_speed * delta

func scale_adjuster():
	tween = create_tween().set_loops()
	tween.tween_property(self, "scale", Vector2(0.8,0.8), 1)
	tween.tween_property(self, "scale", Vector2(1.0,1.0), 1)

func _on_body_entered(body):
	body.add_item(state)
	AudioManager.play_sfx(item_sfx)
	queue_free()
