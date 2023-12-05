extends RigidBody2D

const speed: int = 1500
const grenade_rotation: int = 400
const grenade_flash: float = 0.2
const grenade_countdown: int = 2

func _ready():
	var timer = Timer.new() # Creates a new Timer instance
	add_child(timer)  # Adds the Timer as a child of the current node
	timer.timeout.connect(Callable(self, "_on_timer_timeout")) # Connect the timeout signal to the _on_timer_timeout method
	timer.start(grenade_countdown)  # Start the timer with a wait time in seconds
	angular_velocity = deg_to_rad(grenade_rotation)
	
	var grenade_flash_timer = Timer.new()
	add_child(grenade_flash_timer)
	grenade_flash_timer.timeout.connect(Callable(self, "grenade_flash_timer_reset"))
	grenade_flash_timer.start(grenade_flash)

func _on_timer_timeout(): # This will be called when the timer runs out.
	grenade_explosion()
	
func grenade_flash_timer_reset():
	$PointLight2D.enabled = !$PointLight2D.enabled
	
func grenade_explosion():
	$Explosion.visible = true
	$Sprite2D.visible = false
	$PointLight2D.visible = false
	$ExplosionAnimation.play("Explosion")

