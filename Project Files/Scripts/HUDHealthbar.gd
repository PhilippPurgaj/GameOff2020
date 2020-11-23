extends Control

onready var healthbarFill : TextureRect = $HealthbarFill
var stats = PlayerStats

func set_health_percent(percent):
	healthbarFill.rect_size.x = int(lerp(0, 64, percent))
	
func _ready():
	stats.connect("health_changed", self, "set_health_percent")
