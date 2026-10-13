extends ColorRect
@onready var camera_2d: Camera2D = $Camera2D

func _process(delta: float) -> void:
	await Globals.win
	get_tree().paused = true
	visible = true
	CameraTransition.transition(Globals.electron.camera, camera_2d)
