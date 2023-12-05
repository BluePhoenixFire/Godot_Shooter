#interact_area
extends Area2D

var is_player_inside = false
signal player_in_interaction_area(is_player_inside)

func _ready():
	add_to_group("interactAreas")
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name == "Player":
		is_player_inside = true
		player_in_interaction_area.emit(is_player_inside)
		#print("interact_area script, _on_body_entered " + str(is_player_inside))

func _on_body_exited(body):
	if body.name == "Player":
		is_player_inside = false
		player_in_interaction_area.emit(is_player_inside)
		#print("interact_area script, _on_body_exited " + str(is_player_inside))

func can_interact() -> bool:
	return is_player_inside
