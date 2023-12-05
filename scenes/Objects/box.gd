# Box
extends item_container

enum States {Open, Closed}
var state = States.Closed

func _ready():
	var players = get_tree().get_nodes_in_group("players")
	print(players)
	if players.size() > 0:
		var player = players[0]
		player.player_interacted.connect(_on_player_interact)

func hit():
	print("box")

func _on_player_interact():
	var interact_area = $InteractArea
	if interact_area.can_interact():
		match state:
			States.Closed:
				print("Player opens the box")
				Globals.update_grenade_amount(randi_range(1,3))
				state = States.Open
			States.Open:
				print("The box has already been looted")
			
