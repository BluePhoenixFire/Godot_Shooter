extends LevelParent

func _ready():
	var player = get_node("Player")
	player.player_interacted.connect(_on_player_interact)

func _on_player_interact():
	var Interact_area = get_node("InteractArea")  # Adjust the node path as necessary
	if Interact_area.can_interact():
		TransitionLayer.change_scene("res://scenes/levels/outside.tscn")
