extends Node

@onready var camera2D: Camera2D = $Camera2D

var transitioning: bool = false


func switch_camera(from, to) -> void:
	from.current = false
	to.make_current()

func transition(from: Camera2D, to: Camera2D, duration: float = 1.0) -> void:
	if transitioning: return
	# Copy the parameters of the first camera
	camera2D.zoom = from.zoom
	camera2D.offset = from.offset
	camera2D.light_mask = from.light_mask
	
	# Move our transition camera to the first camera position
	camera2D.global_transform = from.global_transform
	
	# Make our transition camera current
	camera2D.make_current()
	
	transitioning = true
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(camera2D, "global_transform", to.global_transform, duration).from(camera2D.global_transform)
	tween.tween_property(camera2D, "zoom", to.zoom, duration).from(camera2D.zoom)

	# Wait for the tween to complete
	await tween.finished
	
	# Make the second camera current
	to.make_current()
	transitioning = false
