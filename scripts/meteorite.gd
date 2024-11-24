extends Node2D

@export var velocity = Vector2(20, 20)
@export var mass = 10000000 #kg


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += velocity.x * delta
	position.y += velocity.y * delta
	rotation += 0.01
