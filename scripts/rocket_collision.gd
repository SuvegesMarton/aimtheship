extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect("area_entered", _on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_body_entered(body):
	print("collision")
