extends Node2D

var velocity = Vector2.ZERO
var forces = Vector2.ZERO
var weight = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += velocity.x*delta
	position.y += velocity.y*delta
	update_velocity(delta)
	forces = 0
	rotation = velocity.angle()

func update_velocity(delta: float) -> void:
	if weight == 0:
		return
	velocity.x += (forces.x / weight) * delta
	velocity.y += (forces.y / weight) * delta
