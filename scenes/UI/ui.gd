# UI
extends CanvasLayer

# Colours
var green: Color = Color("6bbfa3")
var red: Color = Color(0.9,0,0,1)

@onready var laser_label: Label = $LaserCounter/VBoxContainer/Label
@onready var grenade_label: Label = $GrenadeCounter/VBoxContainer/Label
@onready var laser_icon: TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var grenade_icon: TextureRect = $GrenadeCounter/VBoxContainer/TextureRect
@onready var health_bar: TextureProgressBar = $HealthBar/TextureProgressBar

func _ready():
	update_laser_text()
	update_grenade_text()
	update_health_bar()
	Globals.laser_amount_update.connect(update_laser_text)
	Globals.grenade_amount_update.connect(update_grenade_text)
	Globals.health_amount_update.connect(update_health_bar)

func update_color(amount: int, label: Label, icon: TextureRect) -> void:
	if (amount <= 0):
		icon.modulate = red
		label.modulate = red
	else:
		icon.modulate = green
		label.modulate = green


func update_laser_text():
	laser_label.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount, laser_label, laser_icon)
		

func update_grenade_text():
	grenade_label.text = str(Globals.grenade_amount)
	update_color(Globals.grenade_amount, grenade_label, grenade_icon)
	
func update_health_bar():
	health_bar.value = Globals.health
