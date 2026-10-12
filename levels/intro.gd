extends Node2D

@onready var frame_1: Sprite2D = $frame1
@onready var camera: Camera2D = $Camera2D
@onready var frame_2: Sprite2D = $frame2
@onready var frame_3: Sprite2D = $frame3
@onready var level: Node2D = $"../level"

func _ready() -> void:
	get_tree().paused = true
	camera.make_current()
	
	var frame1_tween = create_tween()
	frame1_tween.set_trans(Tween.TRANS_EXPO)
	frame1_tween.set_ease(Tween.EASE_OUT)
	frame1_tween.tween_property(frame_1, "position", Vector2(-32,44), 1)
	
	var frame2_tween = create_tween()
	frame2_tween.set_trans(Tween.TRANS_EXPO)
	frame2_tween.set_ease(Tween.EASE_OUT)
	frame2_tween.tween_interval(1.5)
	frame2_tween.tween_property(frame_2, "position", Vector2(13,44), 1)
	
	var frame3_tween = create_tween()
	frame3_tween.set_trans(Tween.TRANS_EXPO)
	frame3_tween.set_ease(Tween.EASE_OUT)
	frame3_tween.tween_interval(3)
	frame3_tween.tween_property(frame_3, "position", Vector2(0,20), 2)
	
	await frame3_tween.finished
	
	visible = false
	
	Globals.player_camera.make_current()
	
	level.visible = true
	get_tree().paused = false
	
	
