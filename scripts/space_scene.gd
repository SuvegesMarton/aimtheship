extends Node2D

# Constants for star properties
const STAR_COUNT = 100  # Number of stars
const STAR_MIN_SIZE = 1  # Minimum size of a star
const STAR_MAX_SIZE = 3  # Maximum size of a star

# Reference to the background node
var background: ColorRect

func _ready():
	# Create the adaptive background
	create_background()
	# Generate stars
	generate_stars()
	# Connect to the viewport's size_changed signal for dynamic resizing
	get_viewport().connect("size_changed", _on_window_resized)

func create_background():
	background = ColorRect.new()
	background.color = Color.BLACK
	update_background_size()
	background.z_index = -10  # Push it behind everything else
	add_child(background)

func generate_stars():
	var rng = RandomNumberGenerator.new()  # Random number generator
	for i in STAR_COUNT:
		var star_size = rng.randf_range(STAR_MIN_SIZE, STAR_MAX_SIZE)
		var star_position = Vector2(
			rng.randf_range(0, get_viewport().size.x),
			rng.randf_range(0, get_viewport().size.y)
		)
		
		# Create a new star (white dot)
		var star = ColorRect.new()
		star.color = Color.WHITE
		star.size = Vector2(star_size, star_size)
		star.position = star_position
		star.z_index = -9
		add_child(star)

func update_background_size():
	# Set the background size to match the current viewport size
	background.size = get_viewport().size

func _on_window_resized():
	# Update the background size when the window is resized
	update_background_size()
	generate_stars()
