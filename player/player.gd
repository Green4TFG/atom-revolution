extends CharacterBody2D

@onready var electron_folder: Node2D = $"electron folder"
@onready var nuclei_folder: Node2D = $"nuclei folder"
@onready var camera: Camera2D = $Camera2D
@onready var face: AnimatedSprite2D = $face
@onready var electron_pickup: Area2D = $electronPickup


const ZOOM_RATIOS = [2,1.5,1.2,1,0.8,0.5,0.3,0.2]

const PULL_FORCE = 10000

const ROT_SPEED = 2.0

const SPEED = 500
const JUMP_VELOCITY = -400.0
const FRICTION = 0.98

const ELECTRON_VISUAL = preload("uid://bgah8wptarpd")
var electrons = []
var electron_num = 0.0
var degrees = 0.0
var collecting_electron = false

const NUCLEI = preload("uid://xv7ycaa57amx")
const PROTON_VISUAL = preload("uid://c8pb1unl7wj75")
const PROTON_HIGHLIGHT = preload("uid://brv53b7c4tex6")
const protons = [2, 4, 6, 9, 21, 30]
const NUETRON_HIGHLIGHT = preload("uid://0l1axojheos6")
const NUETRON_VISUAL = preload("uid://dh7o14qbgck7t")
const nuetrons = [2, 4, 7, 12, 33, 44]

var ring_counts = Globals.RING_COUNTS
var ring_size = Globals.RING_SIZE

func _ready() -> void:
	electron_pickup.get_child(0).shape.radius = ((Globals.rings+1) * ring_size) + Globals.FIRST_RING + 20
	Globals.player = self
	face.play("idle")
	add_nuclei()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity.x += (SPEED * Input.get_axis("left","right") * delta)
	
	velocity.y += (SPEED * Input.get_axis("up","down") * delta)
	
	velocity.x *= FRICTION
	
	velocity.y *= FRICTION
	
	degrees +=  ROT_SPEED * delta
	camera.zoom = Vector2(ZOOM_RATIOS[Globals.rings]/(1+(Globals.ELEMENT/5.0)),ZOOM_RATIOS[Globals.rings]/(1+(Globals.ELEMENT/5.0)))
	
	electron_pickup.scale = Vector2(Globals.rings+1,Globals.rings+1)
	electron_pickup.find_child("lineline").material.set_shader_parameter("thick", 2.0/(Globals.rings+1))
	
	move_and_slide()

func add_electron():
	electron_num+=1
	collecting_electron = true
	Globals.rings = Globals.find_ring(electron_num, Globals.RING_SUMS)
	var electron = ELECTRON_VISUAL.instantiate()
	electron.parent = self
	electron.global_position = global_position
	electron.ring = Globals.rings
	electron.true_number = electron_num
	electron.number = electron_num - 1 - ((Globals.RING_COUNTS.slice(0,Globals.rings - 1)).reduce(sum,0)  if Globals.rings > 0 else 0)
	electron.calc_vector()
	electron.get_node("hitbox").collision_layer = 6
	electron.get_node("hitbox").collision_mask = 6
	
	electrons.append(electron)
	electron.visible = false
	collecting_electron = false
	electron_folder.call_deferred("add_child", electron)
	update_electrons()
	
	face.play("happy")
	await get_tree().create_timer(1.5).timeout
	if(!collecting_electron):
		face.play("idle")

func update_electrons():
	for child in electron_folder.get_children():
		child.calc_vector()
		
func sum(accum, number):
	return accum + number

func add_nuclei():
	#creates nuetrons
	var nuetronNum = nuetrons[Globals.ELEMENT-1]
	for i in range(nuetronNum):
		var nuetron = NUETRON_VISUAL.instantiate();
		var highlight = NUETRON_HIGHLIGHT.instantiate();
		var rigidbody = NUCLEI.instantiate()
		
		rigidbody.parent = self
		rigidbody.texture = nuetron
		rigidbody.highlight = highlight
		rigidbody.add_child(nuetron)
		rigidbody.add_child(highlight)
		rigidbody.position = Vector2(randf_range(-100,100),randf_range(-100,100))
		rigidbody.z_index = randf_range(2,6)*9
		nuetron.position = Vector2(0,0)
		nuetron.find_child("outline").z_index = -10
		nuclei_folder.add_child(rigidbody)
	#creates protons
	var protonNum = protons[Globals.ELEMENT-1]
	for i in range(protonNum):
		var proton = PROTON_VISUAL.instantiate();
		var highlight = PROTON_HIGHLIGHT.instantiate();
		var rigidbody = NUCLEI.instantiate()
		rigidbody.parent = self
		rigidbody.texture = proton
		rigidbody.highlight = highlight
		rigidbody.add_child(proton)
		rigidbody.add_child(highlight)
		rigidbody.position = Vector2(randf_range(-50,50),randf_range(-50,50))
		rigidbody.z_index = randf_range(2,6)*9
		proton.position = Vector2(0,0)
		proton.find_child("outline").z_index = -10
		nuclei_folder.add_child(rigidbody)


func _on_electron_pickup_area_entered(area: Area2D) -> void:
	if(area.get_parent() is electron_visual):
		area.get_parent().increment = true




func _on_electron_pickup_area_exited(area: Area2D) -> void:
	if(area.get_parent() is electron_visual):
		area.get_parent().increment = false
