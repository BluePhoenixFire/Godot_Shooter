extends StaticBody2D

func _ready():
	var players = get_tree().get_nodes_in_group("players")
	print(players)
	if players.size() > 0:
		var player = players[0]
		player.player_interacted.connect(_on_player_interact)


func _on_player_interact():
	var interact_area = $InteractArea
	if interact_area.can_interact():
		TransitionLayer.change_scene("res://scenes/levels/inside.tscn")
