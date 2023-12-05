#player
extends CharacterBody2D

#Declared variables
var scorekeeper
var can_laser: bool = true
var can_grenade: bool = true
var shoot_speed: float = 0.5
var grenade_speed: float = 2.0
var max_speed: int = 1000
var player_speed: int = max_speed
var can_interact: bool = true

#Signals
signal player_shot_laser(pos, direction)
signal player_used_grenade(pos, direction)
signal player_interacted()

#functions
func _ready():
	scorekeeper = $Scorekeeper
	add_to_group("players")
	call_deferred("connect_to_interactable_areas")

func _process(_delta):
	#input
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction != Vector2.ZERO:
		velocity = direction * player_speed
		move_and_slide()
		scorekeeper.increment_action_count(get_input_action_as_string())
	#end input
	
	#rotate
	look_at(get_global_mouse_position())
	#end rotate
	

	#Face Mouse Position
	var player_direction = (get_global_mouse_position() - position).normalized()
	
		
	if (Input.is_action_just_pressed("interact") and can_interact):
		emit_signal("player_interacted")
	
		#laser
	if (Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0):
		Globals.update_laser_amount(-1)
		$GPUParticles2D.emitting = true
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		can_laser = false
		player_shot_laser.emit(selected_laser.global_position, player_direction)
		$Timers/LaserTimer.start(shoot_speed)
	#end laser
	
	#grenade
	if (Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0):
		Globals.update_grenade_amount(-1)
		var pos = $LaserStartPositions.get_children()[0].global_position
		can_grenade = false
		player_used_grenade.emit(pos, player_direction)
		$Timers/GrenadeTimer.start(grenade_speed)
	#end grenade
	
#Testing (update)
func print_info():
	print("Postion = " + str(position))
	print("Global Mouse Position = " + str(get_global_mouse_position()))
	print("Normalised = " + str((get_global_mouse_position() - position).normalized()))
	
func connect_to_interactable_areas():
	var interactable_areas = get_tree().get_nodes_in_group("interactAreas")
	for interactable_area in interactable_areas:
		interactable_area.player_in_interaction_area.connect(_on_interaction_area_change)
	
#movement script
func get_input_action_as_string() -> String:
	if Input.is_action_pressed("left"):
		return "left"
	elif Input.is_action_pressed("right"):
		return "right"
	elif Input.is_action_pressed("up"):
		return "up"
	elif Input.is_action_pressed("down"):
		return "down"
	return ""
#End movement


func _on_laser_timer_timeout():
	can_laser = true

func _on_grenade_timer_timeout():
	can_grenade = true

func _on_interaction_area_change(is_inside: bool):
	if is_inside:
		#print("_on_interaction_area_change" + str(is_inside))
		$InteractIcon.show_icon()  # Show the icon
	else:
		$InteractIcon.hide_icon()  # Hide the icon
		#print("_on_interaction_area_change" + str(is_inside))

func add_item(type: String) -> void:
	match type:
		"laser":
			Globals.update_laser_amount(randi_range(5,15))
		"grenade":
			Globals.update_grenade_amount(randi_range(1,3))
		"health":
			Globals.health += 10
			print(Globals.health)
		
