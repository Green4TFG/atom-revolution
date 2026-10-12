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

const ROT_SPEED = 3.0
const DEPLETE_SPEED = 5.0
var setup = false
var electron_parent = null

func _ready() -> void:
	fade.color.a = 0
	camera.make_current()
	enemy.position = Vector2(-130,0)
	player.position = Vector2(130,0)
	qte_name.position = Vector2(0,-64)
	playerbar.position = Vector2(100,25)
	enemybar.position = Vector2(-100,25)
	pointer.position = Vector2(0,64)
	playerbar.value = 50
	enemybar.value = 50
	
	pivot.rotation = randf_range(0,2*PI)
	
	var face = Globals.player.find_child("face").duplicate()
	player.add_child(face)
	var nucle = Globals.player.find_child("nuclei folder").duplicate()
	player.add_child(nucle)
	var s = 2.0/Globals.ELEMENT
	player.scale = Vector2(s,s)
	face.play("serious")
	
	face = Globals.target.accface.duplicate()
	enemy.add_child(face)
	nucle = Globals.target.find_child("nuclei folder").duplicate()
	enemy.add_child(nucle)
	s = 3.0/Globals.target.element
	enemy.scale = Vector2(s,s)
	face.play("serious")
	
	play_cutscene()


func play_cutscene():
	var fade_tween = create_tween()
	fade_tween.tween_property(fade, "color", Color(0.0, 0.0, 0.0, 1.0), 0.5)
	
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
	pointer_tween.tween_property(pointer, "position", Vector2(0,0),0.3)
	
	await pointer_tween.finished
	setup = true
	
func _physics_process(delta: float) -> void:
	if(setup):
		enemybar.value = enemybar.max_value - playerbar.value
		playerbar.value -= (DEPLETE_SPEED * electron_parent.element) * delta
		pointer.rotation += ROT_SPEED * delta
	if(Input.is_action_just_pressed("mouseleft")):
		if(abs(fmod(pointer.rotation,2*PI) - pivot.rotation)) < 0.25*PI:
			print("hit")
			playerbar.value += 10
		else:
			playerbar.value -= 10
