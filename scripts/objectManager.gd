extends Node2D

var RocketScene = preload("res://scenes/rocket.tscn")
var MeteoriteScene = preload("res://scenes/meteorite.tscn")
var EndpointScene = preload("res://scenes/endpoint.tscn")

var levelName = "levelTest"

var G=6.67e-2
var dist_coeff=1.7

var physicsElements = []
var rocket = RocketScene.instantiate()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_level()
	var ep = EndpointScene.instantiate()
	ep.position = Vector2(800, 100)
	add_child(ep)
	#start_movement()	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("fps: ", 1/delta)
	calculateGravityEffects(delta)

func start_movement() -> void:
	for obj in physicsElements:
		obj.movement_enabled = true

func load_level() -> void:
	var config = ConfigFile.new()
	# Load the file. If the file didn't load, ignore it.
	if config.load("res://resources/levels/"+levelName+".cfg") != OK: return
	# Iterate over all sections.
	for item in config.get_sections():
		match item:
			"physics":
				#G used in the gravity equation set to an arbitrary value which works fine
				G = config.get_value(item, "G")
				#d**dist_coeff in gravity equation instead of d**2 to customize gravity function profile
				dist_coeff  = config.get_value(item, "dist_coeff")
			"rocket":
				loadPhysicsAttributesFromFile(config, item, rocket)
			_:
				var met = MeteoriteScene.instantiate()
				loadPhysicsAttributesFromFile(config, item, met)

func loadPhysicsAttributesFromFile(config, item: String, object: Node2D) -> void:
	object.position = config.get_value(item, "pos")
	object.velocity = config.get_value(item, "vel")
	object.weight = config.get_value(item, "weight")
	add_child(object)
	physicsElements.append(object)

#calculate gravity on all physics-affected objects
func calculateGravityEffects(delta: float) -> void:
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
	if distanceSquared<900: return Vector2.ZERO
	#gravity equation
	var forceMagnitude = (G*outer.weight*inner.weight)/(distanceSquared**(dist_coeff/2))
	return direction.normalized() * forceMagnitude
	
	
	
	
	
	
