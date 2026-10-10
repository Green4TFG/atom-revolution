extends CharacterBody2D

@onready var electron_folder: Node2D = $"electron folder"
@onready var camera: Camera2D = $Camera2D

const ZOOM_RATIOS = [3,2,1.5,1.25,1,0.75,0.5,0.25]

const PULL_FORCE = 10000

const ROT_SPEED = 1.0
const RING_SUMS = [2, 10, 18, 36, 54, 86, 118]
var RING_COUNTS = [2, 8, 8, 18, 18] #UPDATE THIS BASED ON DIFFICULTY

const SPEED = 500
const JUMP_VELOCITY = -400.0
const FRICTION = 0.98

const ELECTRON_VISUAL = preload("uid://bgah8wptarpd")
var electrons = []
var electron_num = 0.0
var degrees = 0.0


func _ready() -> void:
	Globals.player = self

func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity.x += (SPEED * Input.get_axis("left","right") * delta)
	
	velocity.y += (SPEED * Input.get_axis("up","down") * delta)
	
	velocity.x *= FRICTION
	
	velocity.y *= FRICTION
	
	degrees =  0.0 if (degrees > 2*PI) else (degrees + (ROT_SPEED * delta))
	camera.zoom = Vector2(ZOOM_RATIOS[Globals.rings],ZOOM_RATIOS[Globals.rings])
	
	move_and_slide()

func add_electron():
	electron_num+=1
	Globals.rings = Globals.find_ring(electron_num)
	var electron = ELECTRON_VISUAL.instantiate()
	electron.global_position = global_position
	electron.ring = Globals.rings
	electron.true_number = electron_num
	electron.number = electron_num - 1 - (RING_SUMS[Globals.rings - 1] if Globals.rings > 0 else 0)
	electron.calc_vector()
	
	electrons.append(electron)
	
	electron_folder.add_child(electron)
	update_electrons()

func update_electrons():
	for child in electron_folder.get_children():
		child.calc_vector()
