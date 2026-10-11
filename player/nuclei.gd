extends RigidBody2D

const PULL_FORCE = 100000

func _physics_process(delta: float) -> void:
	apply_central_force(global_position.direction_to(Globals.player.global_position) * PULL_FORCE * delta)
