extends Node2D

var RocketScene = preload("res://scenes/rocket.tscn")
var MeteoriteScene = preload("res://scenes/meteorite.tscn")
var EndpointScene = preload("res://scenes/endpoint.tscn")

var first_boot = true

var G=6.67e-2
var dist_coeff=1.7

var physicsElements = []

var rocket

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("fps: ", 1/delta)
	calculateGravityEffects(delta)

func start_movement() -> void:
	for obj in physicsElements:
		obj.movement_enabled = true

func loadPhysicsAttributesFromFile(config, item: String, object_type: int) -> void:
	var object
	#object types:
	#0 - rocket
	#1 - meteorite
	#2 - endpoint
	match object_type:
		0:
			object = RocketScene.instantiate()
		1:
			object = MeteoriteScene.instantiate()
		2:
			object = EndpointScene.instantiate()
			object.position = config.get_value(item, "pos")
			add_child(object)
			return
		
	object.position = config.get_value(item, "pos")
	object.velocity = config.get_value(item, "vel")
	object.weight = config.get_value(item, "weight")
	
	add_child(object)
	physicsElements.append(object)
	
	if object_type==0:
		rocket = object
		object.get_node("Area2D").connect("area_entered", rocket_collision)
	
func deletePhysicsElements() -> void:
	for e in physicsElements:
		e.queue_free()
		remove_child(e)
	physicsElements = []

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
	if distanceSquared<100: return Vector2.ZERO #avoid singularities
	#gravity equation
	var forceMagnitude = (G*outer.weight*inner.weight)/(distanceSquared**(dist_coeff/2))
	return direction.normalized() * forceMagnitude
	
func rocket_collision(body):
	print("collision: ", body)
	
	
	
	
	
