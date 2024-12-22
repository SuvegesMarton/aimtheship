extends Button

signal go_button_pressed
signal retry_button_pressed

#0: waiting to start simulation
#1: simulation going, waiting to retry
var state = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	custom_minimum_size = Vector2(get_viewport().size.x/25,get_viewport().size.y*0.1)
	connect("pressed",_on_button_pressed)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_button_pressed():
	match state:
		0:
			go_button_pressed.emit()
			text = "RETRY"
			state = 1
		1:
			retry_button_pressed.emit()
			text = "GO!"
			state = 0
			
			
