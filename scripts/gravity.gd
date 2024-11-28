extends Node2D

var velocity = Vector2.ZERO
var forces = Vector2.ZERO
var weight = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update_velocity(delta: float) -> void:
	if weight == 0:
		return
	velocity.x += (forces.x / weight) * delta
	velocity.y += (forces.y / weight) * delta
	forces = Vector2.ZERO
