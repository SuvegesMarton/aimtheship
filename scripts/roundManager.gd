extends Node2D

var RocketScene = preload("res://scenes/rocket.tscn")
var MeteoriteScene = preload("res://scenes/meteorite.tscn")

var levelName = "levelTest"

var G = 6.67 * (10.0 ** -3)

var physicsElements = []
var rocket = RocketScene.instantiate()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_level(levelName)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("fps: ", 1/delta)
	calculateGravityEffects(delta)
	

func load_level(levelName: String) -> void:
	print(levelName)
	var config = ConfigFile.new()
	# Load the file. If the file didn't load, ignore it.
	if config.load("res://resources/levels/"+levelName+".cfg") != OK: return
	# Iterate over all sections.
	for item in config.get_sections():
		print(item)
		match item:
			"rocket":
				rocket.position = config.get_value(item, "pos")
				rocket.velocity = config.get_value(item, "vel")
				rocket.weight = config.get_value(item, "weight")
				add_child(rocket)
				physicsElements.append(rocket)
			_:
				var met = MeteoriteScene.instantiate()
				met.position = config.get_value(item, "pos")
				met.velocity = config.get_value(item, "vel")
				met.weight = config.get_value(item, "weight")
				add_child(met)
				physicsElements.append(met)
				


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
	
	
	
	
	
	
