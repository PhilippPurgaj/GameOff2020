extends Control

onready var healthbarFill : TextureRect = $HealthbarFill
onready var jetPackbarFill : TextureRect = $JetPackbarFill

var stats = PlayerStats

func set_health_percent(percent):
	healthbarFill.rect_size.x = int(lerp(0, 64, percent))
	
func set_jet_pack_percent(percent):
	jetPackbarFill.rect_size.x = int(lerp(0, 64, percent))
	
func _ready():
	stats.connect("health_changed", self, "set_health_percent")
	stats.connect("jetPack_changed", self, "set_jet_pack_percent")
