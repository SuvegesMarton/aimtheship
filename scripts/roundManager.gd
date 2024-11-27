extends Node2D

var RocketScene = preload("res://scenes/rocket.tscn")
var MeteoriteScene = preload("res://scenes/meteorite.tscn")

var G = 6.67 * (10.0 ** -3)

var physicsElements = []
var rocket
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_level("levelTest")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("fps: ", 1/delta)
	calculateGravityEffects(delta)
	

func load_level(level_name: String) -> void:
	var config = ConfigFile.new()
	# Load the file. If the file didn't load, ignore it.
	if config.load("res://resources/levels/"+level_name+".cfg") != OK:
		return
	# Iterate over all sections.
	for item in config.get_sections():
		print(config.get_sections())
		# Fetch the data for each section.
		var player_name = config.get_value(item, "ala")
		print(player_name)
		var player_score = config.get_value(item, "sala")
		print(player_score)
		var player_score2 = config.get_value(item, "dala")
		print(player_score2)

#calculate gravity on all physics-affected objects
func calculateGravityEffects(delta:float) -> void:
	var arr_size = physicsElements.size()
	for i in range(arr_size):
		for j in range(i+1, arr_size):
			var actingForce: Vector2 = calculateGravityForce(physicsElements[i], physicsElements[j])
			physicsElements[i].forces += actingForce * delta
			physicsElements[j].forces -= actingForce * delta
			
#calculate the forces acting upon "outer"
func calculateGravityForce(outer: Node2D, inner: Node2D) -> Vector2:
	#vector between the 2 objects
	var direction = Vector2(inner.position.x-outer.position.x, inner.position.y-outer.position.y)
	var distanceSquared = direction.x**2+direction.y**2
	#gravity equation
	var forceMagnitude = (G*outer.weight*inner.weight)/distanceSquared
	return direction.normalized() * forceMagnitude
	
	
	
	
	
	
