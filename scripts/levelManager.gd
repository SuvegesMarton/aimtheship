extends Node2D

var levelName = "levelTest"

#0->speed&direction is being modified
#1->simulation going
var phase = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_level()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	match phase:
		0:
			var speed_and_dir = $levelStartUI.get_values()
			$objectManager.rocket.set_speed_and_dir(speed_and_dir[0], speed_and_dir[1])
			if !$levelStartUI.values_under_configuration:
				phase = 1
				$objectManager.start_movement()
		1:
			pass

func load_level() -> void:
	var config = ConfigFile.new()
	# Load the file. If the file didn't load, ignore it.
	if config.load("res://resources/levels/"+levelName+".cfg") != OK: return
	# Iterate over all sections.
	for item in config.get_sections():
		match item:
			"settings":
				#G used in the gravity equation set to an arbitrary value which works fine
				$objectManager.G = config.get_value(item, "G")
				#d**dist_coeff in gravity equation instead of d**2 to customize gravity function profile
				$objectManager.dist_coeff  = config.get_value(item, "dist_coeff")
			"rocket":
				$objectManager.loadPhysicsAttributesFromFile(config, item, $objectManager.rocket)
			_:
				$objectManager.loadPhysicsAttributesFromFile(config, item, null)
