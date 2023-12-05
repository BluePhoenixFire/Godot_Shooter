extends MarginContainer
# This code sample assumes the current script is extending MarginContainer.
var margin_value = 30

func _ready():
	add_theme_constant_override("margin_bottom", margin_value)

