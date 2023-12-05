extends Area2D

#Variables
const SPEED: int = 3000
var direction: Vector2 = Vector2.ZERO
const LASERLIFE: float = 0.5
const LASERFLASHLIGHT: float = 0.05
var laser_sfx: AudioStream = preload("res://audio/laser.wav")
#END Variables

func _ready():
	# Laser Life Timer START
	var laser_life_timer = Timer.new() # Creates a new Timer instance
	add_child(laser_life_timer)  # Adds the Timer as a child of the current node
	laser_life_timer.timeout.connect(Callable(self, "_on_timer_timeout")) # Connect the_ timeout signal to the 
	#_on_timer_timeout method
	laser_life_timer.start(LASERLIFE)  # Start the timer with a wait time in seconds
	# Laser Life Timer END
	
	# Laser Flash Light Timer START
	var laser_flash_light_timer = Timer.new()
	add_child(laser_flash_light_timer)
	laser_flash_light_timer.timeout.connect(Callable(self, "_laser_flash_timer"))
	laser_flash_light_timer.start(LASERFLASHLIGHT)
	# Laser Flash Light Timer END

func _process(delta):
	position += direction.normalized() * SPEED * delta

func _on_timer_timeout(): # This will be called when the timer runs out.
	queue_free()  # Queues a node for deletion at the end of the current frame.

func _laser_flash_timer():
	$laserFlashLight.enabled = false
	
func _on_body_entered(body):
	$Sprite2D.visible = false
	$laserBeamLight.enabled = false
	print(body)
	if "hit" in body:
		body.hit()
	var delay: float = 0.2
	$CollisionShape2D.set_deferred("disabled", true)
	if ($LaserShootSFX.playing):
		var timer = Timer.new()
		timer.one_shot = true
		timer.wait_time = delay
		timer.timeout.connect(Callable(self, "_on_timer_timeout"))
		add_child(timer)
		timer.start()
	else:
		queue_free()
