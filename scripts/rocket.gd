extends Node2D

@export var velocity = Vector2(-20, 50)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += velocity[0]*delta
	position.y += velocity[1]*delta
	velocity.x += 8*delta
	velocity.y += -8*delta
	rotation = velocity.angle()
