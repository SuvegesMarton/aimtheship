extends Node2D

var velocity = Vector2.ZERO
var forces = Vector2.ZERO
var weight = 1

var movement_enabled = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update_velocity(delta: float) -> void:
	if weight == 0:
		return
	forces = round_vector2(forces, 2) # reduce randomness
	velocity.x += (forces.x / weight) * delta
	velocity.y += (forces.y / weight) * delta
	forces = Vector2.ZERO
	
func round_vector2(vec: Vector2, decimals: int) -> Vector2:
	var factor = pow(10, decimals)
	return Vector2(round(vec.x * factor) / factor, round(vec.y * factor) / factor)
