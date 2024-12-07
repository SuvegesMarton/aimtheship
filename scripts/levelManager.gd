extends Node2D

#0->speed&direction is being modified
#1->simulation going
var phase = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

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
