#Interact_Icon
extends Sprite2D

#var pulse_tween: Tween
var player: Node
var initial_start_position: Vector2 = Vector2(-30, -110)

func _ready():
#	pulse_tween = create_tween()
	player = get_parent()  # Assuming the interact icon is a direct child of the player
	position = initial_start_position
	hide()  # Start with the icon hidden

func _process(_delta):
	if is_visible():
		global_rotation = 0
		position = initial_start_position.rotated(player.rotation)

#func start_pulse_animation():
#	pulse_tween.tween_property(self, "scale", Vector2(2.2, 2.2), 1).set_ease(Tween.EASE_IN_OUT)
#	pulse_tween.tween_property(self, "scale", Vector2(2.0, 2.0), 1).set_ease(Tween.EASE_IN_OUT)

func _on_Player_interact_area_entered():
	print("show_icon called")
	show_icon()

func _on_Player_interact_area_exited():
	print("hide icon called")
	hide_icon()

func show_icon():
	show()
#	start_pulse_animation()

func hide_icon():
	hide()
#	pulse_tween.stop_all()
