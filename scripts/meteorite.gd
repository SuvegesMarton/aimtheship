extends "res://scripts/gravity.gd"

var rot_magn = randf_range(6,12)/10
var rot_dir = randi_range(0,1)*2-1 #1/-1 for clockwise/counterclockwise rotation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !movement_enabled:
		forces = Vector2.ZERO
		return
	position.x += velocity.x * delta
	position.y += velocity.y * delta
	update_velocity(delta)
	rotation += rot_magn*rot_dir*delta
