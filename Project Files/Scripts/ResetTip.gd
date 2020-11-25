extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func set_jet_pack_percent(percent):
	if percent == 0:
		self.visible = true;
	else:
		self.visible = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerStats.connect("jetPack_changed", self, "set_jet_pack_percent")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
