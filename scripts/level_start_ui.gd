extends Node2D

var values_under_configuration = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$speed.position = Vector2(0, 0)
	$direction.position = Vector2(get_viewport().size.x/50, 0)
	$go_button.position = Vector2(0, get_viewport().size.y*0.9)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func get_values():
	return [$speed.get_val(), $direction.get_val()]
	
