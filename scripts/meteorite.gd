extends "res://scripts/gravity.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += velocity.x * delta
	position.y += velocity.y * delta
	update_velocity(delta)
	rotation += 0.01
