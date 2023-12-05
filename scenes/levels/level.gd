extends Node2D
class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/Projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/Projectiles/Grenade.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func _on_player_player_shot_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	var angle = atan2(direction.x, -direction.y)
	laser.position = pos
	laser.direction = direction
	laser.rotation = angle	
	$Projectiles.add_child(laser)

func _on_player_player_used_grenade(pos, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)


func _on_house_player_entered():
	var player_enter_camera = get_tree().create_tween()
	player_enter_camera.tween_property($Player/Camera2D, "zoom", Vector2(0.6,0.6),1)

func _on_house_player_exited():
	var player_exit_camera = get_tree().create_tween()
	player_exit_camera.tween_property($Player/Camera2D, "zoom", Vector2(0.4,0.4),1)
