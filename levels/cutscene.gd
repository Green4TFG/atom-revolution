extends Node2D

@onready var enemy: Sprite2D = $enemy
@onready var player: Sprite2D = $player
@onready var qte_name: Sprite2D = $"qte name"
@onready var ring: Sprite2D = $ring
@onready var pointer: Sprite2D = $pointer
@onready var enemybar: TextureProgressBar = $enemybar
@onready var camera: Camera2D = $Camera2D


func _ready() -> void:
	camera.make_current()
	enemy.position = Vector2(-130,0)
	player.position = Vector2(130,0)
	qte_name.position = Vector2(0,-64)
	
	play_cutscene()


func play_cutscene():
	var enemy_slide = create_tween()
	enemy_slide.set_trans(Tween.TRANS_EXPO)
	enemy_slide.set_ease(Tween.EASE_OUT)
	enemy_slide.tween_property(enemy, "position", Vector2(-85,0), 0.4)
	
	var player_slide = create_tween()
	player_slide.set_trans(Tween.TRANS_EXPO)
	player_slide.set_ease(Tween.EASE_OUT)
	player_slide.tween_interval(0.1)
	player_slide.tween_property(player, "position", Vector2(85,0), 0.4)
	
	var name_slide = create_tween()
	name_slide.set_trans(Tween.TRANS_EXPO)
	name_slide.set_ease(Tween.EASE_IN)
	name_slide.tween_interval(0.02)
	player_slide.tween_property(qte_name, "position", Vector2(0,-35), 0.2)
	
