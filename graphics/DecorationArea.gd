extends Area2D

var decorations = [
	preload("res://graphics/decals/moss/moss_1.png"),
	preload("res://graphics/decals/moss/moss_2.png"),
	preload("res://graphics/decals/moss/moss_3.png"),
	preload("res://graphics/decals/moss/moss_4.png"),
	preload("res://graphics/decals/moss/moss_5.png"),
	preload("res://graphics/decals/blood.png"),
	preload("res://graphics/decals/ceiling_hole1.png"),
	preload("res://graphics/decals/dirt_patch.png")
	]

# Called when the node enters the scene tree for the first time.
func _ready():
	create_random_decoration()

func create_random_decoration():
	var sprite = Sprite2D.new()
	add_child(sprite)
	sprite.texture = decorations[randi() % decorations.size()]
	sprite.position = randomize_position_within_bounds()
	sprite.rotation_degrees = randf_range(0, 360)
	sprite.scale = Vector2(randf_range(0.8, 1.1), randf_range(0.8, 1.1))
		

func randomize_position_within_bounds() -> Vector2:
	var shape = $DecorationAreaShape.shape
	var random_position = Vector2()
	
	if shape is RectangleShape2D:
		var rect = shape.extents
		random_position.x = randf_range(-rect.x, rect.x)
		random_position.y = randf_range(-rect.y, rect.y)
	elif shape is CircleShape2D:
		var radius = shape.radius
		random_position = Vector2(randf_range(-radius, radius), randf_range(-radius, radius))
	
	# Debugging
	#print(shape)
	#print(random_position)
	
	return random_position
