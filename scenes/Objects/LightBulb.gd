extends PointLight2D

# START Variables
var random = RandomNumberGenerator.new()
var LightOffTimeFrom: float = 0.05
var LightOffTimeTo: float = 1
var lightOffTimer = Timer.new()
# END Variables

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(lightOffTimer)
	lightOffTimer.timeout.connect(Callable(self, "light_switch"))
	light_switch()

func random_generator2() -> float:
	return random.randf_range(LightOffTimeFrom, LightOffTimeTo)

func light_switch():
	self.energy = random.randf_range(0.5,2)
	self.enabled = !self.enabled
	lightOffTimer.start(random_generator2())
