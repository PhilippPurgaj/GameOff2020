extends Node

onready var health_percent = 1.0

signal no_health
signal health_changed(percent)

func take_damage(damage):
	set_health(health_percent - damage) 

func set_health(percent):
	health_percent = percent
	emit_signal("health_changed", health_percent)
	if health_percent <= 0:
		emit_signal("no_health")
