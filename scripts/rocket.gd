extends "res://scripts/gravity.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation = velocity.angle()
	if !movement_enabled:
		forces = Vector2.ZERO
		return
	position.x += velocity[0]*delta
	position.y += velocity[1]*delta
	update_velocity(delta)
	
func set_speed_and_dir(speed: float, dir: float) -> void:
	velocity = speed*Vector2.from_angle(deg_to_rad(-dir))
