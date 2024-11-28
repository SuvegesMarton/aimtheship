extends "res://scripts/gravity.gd"

var movement_enabled = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation = velocity.angle()
	if !movement_enabled: return
	position.x += velocity[0]*delta
	position.y += velocity[1]*delta
	update_velocity(delta)
