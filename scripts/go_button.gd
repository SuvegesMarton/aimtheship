extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#scale = Vector2(1,1)
	custom_minimum_size = Vector2(get_viewport().size.x/25,get_viewport().size.y*0.1)
	#value = 50.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
