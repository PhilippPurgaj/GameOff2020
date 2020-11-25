extends Node

onready var health_percent = 1.0
onready var jetPack_percent = 1.0

signal no_health
signal health_changed(percent)
signal jetPack_changed(percent)

func take_damage(damage):
	set_health(health_percent - damage) 

func set_jetPack(percent):
	jetPack_percent = clamp(percent, 0, 1)
	emit_signal("jetPack_changed", jetPack_percent)

func set_health(percent):	
	health_percent = clamp(percent, 0, 1)
	emit_signal("health_changed", health_percent)
	if health_percent <= 0:
		emit_signal("no_health")
