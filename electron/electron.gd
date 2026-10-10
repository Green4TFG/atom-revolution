extends RigidBody2D

const PULL_RADIUS = 100

const RING_SUMS = [2, 10, 18, 36, 54, 86, 118]


var ring_num = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

	
func _physics_process(delta: float) -> void:
	if(Globals.player):
		if global_position.distance_to(Globals.player.global_position) < PULL_RADIUS:
			#print("pulling")
			apply_central_force(global_position.direction_to(Globals.player.global_position) * Globals.player.PULL_FORCE * delta)





func _on_pickup_range_body_entered(body: Node2D) -> void:
	if body == Globals.player:
		Globals.player.add_electron()
		queue_free()


	
