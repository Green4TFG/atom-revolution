extends Node2D

@onready var enemy: Sprite2D = $enemy
@onready var player: Sprite2D = $player
@onready var qte_name: Sprite2D = $"qte name"
@onready var ring: Sprite2D = $ring
@onready var pointer: Node2D = $pointer
@onready var enemybar: TextureProgressBar = $enemybar
@onready var camera: Camera2D = $Camera2D
@onready var playerbar: TextureProgressBar = $playerbar
@onready var pivot: Node2D = $SubViewport/offset/pivot
@onready var fade: ColorRect = $ColorRect
var eneface
var plaface

var ROT_SPEED = 4.0
const DEPLETE_SPEED = 0.7
var setup = false
var electron_parent = null

signal finished

func _ready() -> void:
	ROT_SPEED = 4.0 * (Globals.ELEMENT/2.0)
	fade.color.a = 0
	fade.find_child("bg").modulate.a = 0
	camera.make_current()
	enemy.position = Vector2(-130,0)
	player.position = Vector2(130,0)
	qte_name.position = Vector2(0,-64)
	playerbar.position = Vector2(100,35)
	enemybar.position = Vector2(-100,35)
	pointer.position = Vector2(0,64)
	playerbar.value = 50
	enemybar.value = 50
	
	pivot.rotation = randf_range(0,2*PI)
	
	plaface = Globals.player.find_child("face").duplicate()
	player.add_child(plaface)
	var nucle = Globals.player.find_child("nuclei folder").duplicate()
	player.add_child(nucle)
	var s = 1.3/(Globals.target.element/2)
	player.scale = Vector2(s,s)
	plaface.play("serious")
	
	eneface = Globals.target.accface.duplicate()
	enemy.add_child(eneface)
	nucle = Globals.target.find_child("nuclei folder").duplicate()
	enemy.add_child(nucle)
	s = 1.3/(Globals.target.element/2)
	enemy.scale = Vector2(s,s)
	enemy.rotation = 0
	eneface.play("serious")
	
	play_cutscene()

func play_cutscene():
	var fade_tween = create_tween()
	fade_tween.tween_property(fade, "color", Color(0.0, 0.0, 0.0, 1.0), 0.5)
	fade_tween.tween_property(fade.find_child("bg"), "modulate", Color(0.196, 0.196, 0.196, 1.0), 0.5)
	print("faded")
	
	var enemy_slide = create_tween()
	enemy_slide.set_trans(Tween.TRANS_EXPO)
	enemy_slide.set_ease(Tween.EASE_OUT)
	enemy_slide.tween_property(enemy, "position", Vector2(-85,0), 0.75)
	
	var player_slide = create_tween()
	player_slide.set_trans(Tween.TRANS_EXPO)
	player_slide.set_ease(Tween.EASE_OUT)
	player_slide.tween_interval(0.3)
	player_slide.tween_property(player, "position", Vector2(85,0), 0.75)
	
	var name_slide = create_tween()
	name_slide.set_trans(Tween.TRANS_CUBIC)
	name_slide.set_ease(Tween.EASE_OUT)
	name_slide.tween_interval(0.1)
	name_slide.tween_property(qte_name, "position", Vector2(0,-45), 0.2)
	
	var bar_crash1 = create_tween()
	bar_crash1.set_trans(Tween.TRANS_BOUNCE)
	bar_crash1.set_ease(Tween.EASE_OUT)
	bar_crash1.tween_property(enemybar, "position", Vector2(0,35),0.5)
	var bar_crash2 = create_tween()
	bar_crash2.set_trans(Tween.TRANS_BOUNCE)
	bar_crash2.set_ease(Tween.EASE_OUT)
	bar_crash2.tween_property(playerbar, "position", Vector2(0,35),0.5)
	
	var pointer_tween = create_tween()
	pointer_tween.set_trans(Tween.TRANS_CUBIC)
	pointer_tween.set_ease(Tween.EASE_OUT)
	pointer_tween.tween_property(pointer, "position", Vector2(0,0),0.3)
	
	await pointer_tween.finished
	setup = true
	
func unplay_cutscene():
	var fade_tween = create_tween()
	fade_tween.tween_property(fade, "color", Color(0.0, 0.0, 0.0, 1.0), 0.5)
	fade_tween.tween_property(fade.find_child("bg"), "modulate", Color(0.196, 0.196, 0.196, 1.0), 0.5)
	print("faded")
	
	var enemy_slide = create_tween()
	enemy_slide.set_trans(Tween.TRANS_EXPO)
	enemy_slide.set_ease(Tween.EASE_OUT)
	enemy_slide.tween_property(enemy, "position", Vector2(-85,0), 0.75)
	
	var player_slide = create_tween()
	player_slide.set_trans(Tween.TRANS_EXPO)
	player_slide.set_ease(Tween.EASE_OUT)
	player_slide.tween_interval(0.3)
	player_slide.tween_property(player, "position", Vector2(85,0), 0.75)
	
	var name_slide = create_tween()
	name_slide.set_trans(Tween.TRANS_CUBIC)
	name_slide.set_ease(Tween.EASE_OUT)
	name_slide.tween_interval(0.1)
	name_slide.tween_property(qte_name, "position", Vector2(0,-45), 0.2)
	
	var bar_crash1 = create_tween()
	bar_crash1.set_trans(Tween.TRANS_BOUNCE)
	bar_crash1.set_ease(Tween.EASE_OUT)
	bar_crash1.tween_property(enemybar, "position", Vector2(0,35),0.5)
	var bar_crash2 = create_tween()
	bar_crash2.set_trans(Tween.TRANS_BOUNCE)
	bar_crash2.set_ease(Tween.EASE_OUT)
	bar_crash2.tween_property(playerbar, "position", Vector2(0,35),0.5)
	
	var pointer_tween = create_tween()
	pointer_tween.set_trans(Tween.TRANS_CUBIC)
	pointer_tween.set_ease(Tween.EASE_OUT)
	pointer_tween.tween_property(pointer, "position", Vector2(0,0),0.3)
	
	await pointer_tween.finished
	setup = true
	
func _physics_process(delta: float) -> void:
	if(setup):
		enemybar.value = enemybar.max_value - playerbar.value
		playerbar.value -= (DEPLETE_SPEED * Globals.target.element) * delta
		pointer.rotation += ROT_SPEED * delta
		if(Input.is_action_just_pressed("mouseleft")):
			if(abs(angle_difference(pointer.rotation, pivot.rotation))) < 0.25*PI:
				playerbar.value += 20 * (1-(abs(angle_difference(pointer.rotation, pivot.rotation)))*2.0)
				ROT_SPEED += 0.3 * ((ROT_SPEED/abs(ROT_SPEED)) / (Globals.target.element/2))
				ROT_SPEED *= -1
				var tib = create_tween()
				tib.set_ease(Tween.EASE_IN_OUT)
				tib.tween_property(pivot, "rotation", pivot.rotation+randf_range(-PI,PI), 0.1)
			else:
				playerbar.value -= 5
				ROT_SPEED -= 0.05 * (ROT_SPEED/abs(ROT_SPEED))
		if(playerbar.value > 99):
			setup = false
			plaface.play("happy")
			eneface.play("panic")
			enemybar.value = 0
			playerbar.value = 100
			await get_tree().create_timer(1.0).timeout
			Globals.winner = "player"
			finished.emit()
			
			queue_free()
		elif(enemybar.value > 99):
			plaface.play("panic")
			eneface.play("happy")
			enemybar.value = 100
			playerbar.value = 0
			setup = false
			await get_tree().create_timer(1.0).timeout
			
			Globals.winner = "enemy"
			finished.emit()
			queue_free()
