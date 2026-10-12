extends Node2D

const LEVEL = preload("uid://3md2ko84i7u")

func _on_button_pressed() -> void:
	var level = LEVEL.instantiate()
	add_sibling(level)
	Globals.player_camera.make_current()
	queue_free()
