extends RigidBody2D

const PULL_FORCE = 400000
var highlight = null
var parent = null
var texture = null

func _physics_process(delta: float) -> void:
	if(highlight):
		if(parent == Globals.player):
			highlight.rotation = rotation * -1
		else:
			highlight.rotation = (rotation + parent.rotation) * -1
	if(parent):
		apply_central_force(global_position.direction_to(parent.global_position) * PULL_FORCE * delta)
		
