extends Node2D

const LEVEL = preload("uid://3md2ko84i7u")
const hel = preload("uid://c6bkpyn0bduf1")
@onready var a: AudioStreamPlayer = $"../a"
@onready var b: AudioStreamPlayer = $"../b"
@onready var fktitle: Sprite2D = $"../intro/title"
@onready var title: Sprite2D = $title
@onready var da: Sprite2D = $da

func _ready() -> void:
	a.play()
	a.finished.connect(_introed)
	
func _introed():
	b.play()

func make():
	var t = create_tween()
	bring()
	t.set_parallel(true)
	t.set_trans(Tween.TRANS_CUBIC)
	t.set_ease(Tween.EASE_IN_OUT)
	t.tween_property(title, "scale", Vector2(1.5,1.5), 1)
	t.tween_property(title, "position", Vector2(0,-180), 1)

func bring():
	var t = create_tween()
	t.set_parallel(true)
	t.set_trans(Tween.TRANS_CUBIC)
	t.set_ease(Tween.EASE_IN_OUT)
	t.tween_property(da, "position", Vector2(0,76), 1)

func _on_button_pressed() -> void:
	var level = LEVEL.instantiate()
	add_sibling(level)
	Globals.player_camera.make_current()
	Globals.set_level(1)
	queue_free()
