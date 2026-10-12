extends Node2D

const LEVEL = preload("uid://3md2ko84i7u")
@onready var a: AudioStreamPlayer = $"../a"
@onready var b: AudioStreamPlayer = $"../b"

func _ready() -> void:
	a.play()
	a.finished.connect(_introed)
	
func _introed():
	b.play()

func _on_button_pressed() -> void:
	var level = LEVEL.instantiate()
	add_sibling(level)
	Globals.player_camera.make_current()
	queue_free()
