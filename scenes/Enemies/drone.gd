extends CharacterBody2D

const SPEED = 300.0
var health: int = 30

func _ready():
	pass

func _process(_delta):
	var direction = Vector2.RIGHT
	velocity = direction * SPEED
	move_and_slide()

func hit():
	health -= 10
	print(health)
