extends VSlider


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale = Vector2(1,1)
	size = Vector2(get_viewport().size.x/50,get_viewport().size.y*0.9)
	editable = true
	value = max_value/3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func get_val() -> float:
	return value
	
func turn_off() -> void:
	editable = false
	
func turn_on() -> void:
	editable = true
