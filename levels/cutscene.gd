extends Node2D

@onready var enemy: Sprite2D = $enemy
@onready var player: Sprite2D = $player
@onready var qte_name: Sprite2D = $"qte name"
@onready var ring: Sprite2D = $ring
@onready var pointer: Sprite2D = $pointer
@onready var enemybar: TextureProgressBar = $enemybar
@onready var camera: Camera2D = $Camera2D
@onready var playerbar: TextureProgressBar = $playerbar


func _ready() -> void:
	camera.make_current()
	enemy.position = Vector2(-130,0)
	player.position = Vector2(130,0)
	qte_name.position = Vector2(0,-64)
	playerbar.position = Vector2(100,25)
	enemybar.position = Vector2(-100,25)
	pointer.position = Vector2(10,64)
	
	
	play_cutscene()


func play_cutscene():
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
	name_slide.tween_property(qte_name, "position", Vector2(0,-35), 0.2)
	
	var bar_crash1 = create_tween()
	bar_crash1.set_trans(Tween.TRANS_BOUNCE)
	bar_crash1.set_ease(Tween.EASE_OUT)
	bar_crash1.tween_property(enemybar, "position", Vector2(0,25),0.5)
	var bar_crash2 = create_tween()
	bar_crash2.set_trans(Tween.TRANS_BOUNCE)
	bar_crash2.set_ease(Tween.EASE_OUT)
	bar_crash2.tween_property(playerbar, "position", Vector2(0,25),0.5)
	
	var pointer_tween = create_tween()
	pointer_tween.set_trans(Tween.TRANS_CUBIC)
	pointer_tween.set_ease(Tween.EASE_OUT)
	pointer_tween.tween_property(pointer, "position", Vector2(10,0),0.3)
	
