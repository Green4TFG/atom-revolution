extends Node2D

@onready var frame_1: Sprite2D = $frame1
@onready var camera: Camera2D = $Camera2D
@onready var frame_2: Sprite2D = $frame2
@onready var frame_3: Label = $frame3
@onready var level: Node2D = $"../Main"
@onready var title: Sprite2D = $title
@onready var bg: ColorRect = $ColorRect
var dome = false

func _ready() -> void:
	camera.make_current()
	title.modulate = Color(1,1,1,0)
	var frame1_tween = create_tween()
	frame1_tween.set_trans(Tween.TRANS_EXPO)
	frame1_tween.set_ease(Tween.EASE_OUT)
	frame1_tween.tween_property(frame_1, "position", Vector2(-32,244), 1)
	
	var frame2_tween = create_tween()
	frame2_tween.set_trans(Tween.TRANS_EXPO)
	frame2_tween.set_ease(Tween.EASE_OUT)
	frame2_tween.tween_interval(1)
	frame2_tween.tween_property(frame_2, "position", Vector2(13,244), 1)
	
	var frame3_tween = create_tween()
	frame3_tween.set_trans(Tween.TRANS_EXPO)
	frame3_tween.set_ease(Tween.EASE_OUT)
	frame3_tween.tween_interval(1.5)
	frame3_tween.tween_property(frame_3, "position", Vector2(-500,184), 2)
	
	var pt1 = create_tween()
	pt1.set_trans(Tween.TRANS_EXPO)
	pt1.set_ease(Tween.EASE_IN_OUT)
	pt1.tween_interval(1.8)
	pt1.tween_property(title, "modulate", Color(1,1,1,0.5), 0.5)
	await pt1.finished
	var pt2 = create_tween()
	pt2.set_trans(Tween.TRANS_EXPO)
	pt2.set_ease(Tween.EASE_IN_OUT)
	pt2.tween_property(title, "modulate", Color(1,1,1,1), 1)
	await pt2.finished
	unseen()

func unseen():
	if dome:
		return
	level.show()
	level.make()
	title.hide()
	dome = true
	var bgsc = create_tween()
	bgsc.set_trans(Tween.TRANS_EXPO)
	bgsc.set_ease(Tween.EASE_OUT)
	bgsc.set_parallel(true)
	bgsc.tween_interval(0.1)
	bgsc.tween_property(bg, "color", Color(0,0,0,0), 1.4)
	
	var frame1_tween = create_tween()
	frame1_tween.set_trans(Tween.TRANS_EXPO)
	frame1_tween.set_ease(Tween.EASE_OUT)
	frame1_tween.set_parallel(true)
	frame1_tween.tween_property(frame_1, "position", Vector2(-1000,244), 1.4)
	
	var frame2_tween = create_tween()
	frame2_tween.set_trans(Tween.TRANS_EXPO)
	frame2_tween.set_ease(Tween.EASE_OUT)
	frame2_tween.set_parallel(true)
	frame2_tween.tween_property(frame_2, "position", Vector2(1000,244), 1.4)
	
	var frame3_tween = create_tween()
	frame3_tween.set_trans(Tween.TRANS_EXPO)
	frame3_tween.set_ease(Tween.EASE_OUT)
	frame3_tween.set_parallel(true)
	frame3_tween.tween_property(frame_3, "position", Vector2(-500,400), 1.4)
	await frame3_tween.finished
	self.hide()
	queue_free()
		
	
	
