extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$speed.position = Vector2(0, 0)
	$direction.position = Vector2(get_viewport().size.x/50, 0)
	$button.position = Vector2(1, get_viewport().size.y*0.9-1)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func disable_edit():
	$speed.editable=false
	$direction.editable=false
	#$go_button.disabled=true

func enable_edit():
	$speed.editable=true
	$direction.editable=true
	#$go_button.disabled=true	

func get_values():
	return [$speed.get_val(), $direction.get_val()]
	
