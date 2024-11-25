extends Node2D

var RocketScene = preload("res://scenes/rocket.tscn")
var MeteoriteScene = preload("res://scenes/meteorite.tscn")

var G = 6.67 * (10 ** -11)

var physicsElements = []
var rocket
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(G)
	rocket = RocketScene.instantiate() as Node2D
	rocket.position = Vector2(300, 300)
	rocket.velocity = Vector2(40, 40)
	rocket.weight = 0
	add_child(rocket)
	physicsElements.append(rocket)
	
	var m1 = MeteoriteScene.instantiate() as Node2D
	m1.position = Vector2(800, 300)
	m1.velocity = Vector2(0, 0)
	m1.weight = 1
	add_child(m1)
	physicsElements.append(m1)
	
	var m2 = MeteoriteScene.instantiate() as Node2D
	m2.position = Vector2(500, 300)
	m2.velocity = Vector2(0, 0)
	m2.weight = 0
	add_child(m2)
	physicsElements.append(m2)
	#for i in range

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	calculateGravityEffects(delta)
	
	
	
	
	
	
	
func calculateGravityEffects(delta:float) -> void:
	for outer in physicsElements:
		for inner in physicsElements:
			outer.forces += calculateGravityForce(outer, inner) * delta
			
#calculate the forces acting upon "outer"
func calculateGravityForce(outer: Node2D, inner: Node2D) -> Vector2:
	#vector between the 2 objects
	var direction = Vector2(outer.position.x-inner.position.x, outer.position.y-inner.position.y)
	var distanceSquared = direction.x**2+direction.y**2
	#gravity equation
	var forceMagnitude = (G*outer.weight*inner.weight)/distanceSquared
	return direction.normalized() * forceMagnitude
	
	
	
	
	
	
