# Globals
extends Node

var laser_amount: int = 20
var grenade_amount: int = 3
var health: int = 70:
	get:
		return health
	set(value):
		health = value
		health_amount_update.emit()

signal laser_amount_update
signal grenade_amount_update
signal health_amount_update

func update_laser_amount(amount: int):
	laser_amount += amount
	laser_amount_update.emit()

func update_grenade_amount(amount: int):
	grenade_amount += amount
	grenade_amount_update.emit()

