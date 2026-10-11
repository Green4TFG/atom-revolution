extends CharacterBody2D

@onready var electron_folder: Node2D = $"electron folder"
@onready var nuclei_folder: Node2D = $"nuclei folder"
@onready var camera: Camera2D = $Camera2D

const ZOOM_RATIOS = [2.5,1.9,1.4,1.15,0.9,0.75,0.5,0.25]

const PULL_FORCE = 10000

const ROT_SPEED = 3.0

const SPEED = 500
const JUMP_VELOCITY = -400.0
const FRICTION = 0.98

const ELECTRON_VISUAL = preload("uid://bgah8wptarpd")
var electrons = []
var electron_num = 0.0
var degrees = 0.0

const NUCLEI = preload("uid://xv7ycaa57amx")
const PROTON_VISUAL = preload("uid://c8pb1unl7wj75")
const protons = [2, 4, 6, 9, 21]
const NUETRON_VISUAL = preload("uid://dh7o14qbgck7t")
const nuetrons = [2, 4, 7, 12, 33]

func _ready() -> void:
	Globals.player = self
	add_nuclei()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity.x += (SPEED * Input.get_axis("left","right") * delta)
	
	velocity.y += (SPEED * Input.get_axis("up","down") * delta)
	
	velocity.x *= FRICTION
	
	velocity.y *= FRICTION
	
	degrees +=  ROT_SPEED * delta
	camera.zoom = Vector2(ZOOM_RATIOS[Globals.rings]/(1+(Globals.ELEMENT/5)),ZOOM_RATIOS[Globals.rings]/(1+(Globals.ELEMENT/5)))
	
	move_and_slide()

func add_electron():
	electron_num+=1
	Globals.rings = Globals.find_ring(electron_num)
	var electron = ELECTRON_VISUAL.instantiate()
	electron.global_position = global_position
	electron.ring = Globals.rings
	electron.true_number = electron_num
	electron.number = electron_num - 1 - ((Globals.RING_COUNTS.slice(0,Globals.rings - 1)).reduce(sum,0)  if Globals.rings > 0 else 0)
	electron.calc_vector()
	
	electrons.append(electron)
	
	electron_folder.add_child(electron)
	update_electrons()

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
		var rigidbody = NUCLEI.instantiate()
		rigidbody.add_child(nuetron)
		rigidbody.position = Vector2(randf_range(-10,10),randf_range(-10,10))
		nuetron.position = Vector2(0,0)
		nuclei_folder.add_child(rigidbody)
	#creates protons
	var protonNum = protons[Globals.ELEMENT-1]
	for i in range(protonNum):
		var proton = PROTON_VISUAL.instantiate();
		var rigidbody = NUCLEI.instantiate()
		rigidbody.add_child(proton)
		rigidbody.position = Vector2(randf_range(-10,10),randf_range(-10,10))
		proton.position = Vector2(0,0)
		nuclei_folder.add_child(rigidbody)
