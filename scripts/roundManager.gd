extends Node2D

var RocketScene = preload("res://scenes/rocket.tscn")
var MeteoriteScene = preload("res://scenes/meteorite.tscn")

var G = 6.67 * (10.0 ** -3)

var physicsElements = []
var rocket
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rocket = RocketScene.instantiate() as Node2D
	rocket.position = Vector2(300, 300)
	rocket.velocity = Vector2(0, 60)
	rocket.weight = 1
	add_child(rocket)
	physicsElements.append(rocket)
	
	var m1 = MeteoriteScene.instantiate() as Node2D
	m1.position = Vector2(500, 300)
	m1.velocity = Vector2(0, 0)
	m1.weight = 10000000000
	add_child(m1)
	physicsElements.append(m1)
	"""
	var m2 = MeteoriteScene.instantiate() as Node2D
	m2.position = Vector2(500, 300)
	m2.velocity = Vector2(0, 0)
	m2.weight = 100000000
	add_child(m2)
	physicsElements.append(m2)
	"""
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(rocket.velocity)
	calculateGravityEffects(delta)
	

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
	print(forceMagnitude)
	return direction.normalized() * forceMagnitude
	
	
	
	
	
	
