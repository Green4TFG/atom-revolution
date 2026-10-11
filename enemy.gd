extends RigidBody2D

const ELECTRON_VISUAL = preload("uid://bgah8wptarpd")
@onready var electron_folder: Node2D = $"electron folder"
const PROTON_VISUAL = preload("uid://c8pb1unl7wj75")
const NUETRON_VISUAL = preload("uid://dh7o14qbgck7t")
const NUCLEI = preload("uid://xv7ycaa57amx")
@onready var nuclei_folder: Node2D = $"nuclei folder"

const electrons = [[2,8],[2,8,8],[2,8,18,8],[2,8,18,18,8],[2,8,18,32,18,8],[2,8,18,32,32,18,8]]
const protons = [2, 4, 6, 9, 21, 30]
const nuetrons = [2, 4, 7, 12, 33, 44]

@export var element = 1
var ring_counts = electrons[element-1]
var total_electrons = ring_counts.reduce(sum, 0)
var rings = 0
var ring_sums = []


func _ready() -> void:
	
	ring_counts = electrons[element-1]
	for i in ring_counts.size() :
		ring_sums.append( ring_counts.slice(0,i+1).reduce(sum,0))
	add_nuclei()
	total_electrons = ring_counts.reduce(sum, 0)
	add_electrons()

func update_electrons():
	for child in electron_folder.get_children():
		child.calc_vector()

		
func sum(accum, number):
	return accum + number

func add_electrons():
	for electron_num in range(total_electrons+1):
		var electron = ELECTRON_VISUAL.instantiate()
		electron.parent = self
		rings = Globals.find_ring(electron_num, ring_sums)
		electron.global_position = global_position
		electron.ring = rings
		electron.true_number = electron_num
		print(rings)
		electron.number = electron_num - 1 - ((ring_counts.slice(0,rings - 1)).reduce(sum,0)  if rings > 0 else 0)
		electron.calc_vector()
	
		electron_folder.add_child(electron)
		update_electrons()


func add_nuclei():
	#creates nuetrons
	var neutronNum = nuetrons[element-1]
	for i in range(neutronNum):
		var nuetron = NUETRON_VISUAL.instantiate();
		var rigidbody = NUCLEI.instantiate()
		rigidbody.parent = self
		rigidbody.texture = nuetron
		rigidbody.add_child(nuetron)
		rigidbody.position = Vector2(randf_range(-100,100),randf_range(-100,100))
		nuetron.position = Vector2(0,0)
		nuclei_folder.add_child(rigidbody)
	#creates protons
	var protonNum = protons[element-1]
	for i in range(protonNum):
		var proton = PROTON_VISUAL.instantiate();
		var rigidbody = NUCLEI.instantiate()
		rigidbody.parent = self
		rigidbody.texture = proton
		rigidbody.add_child(proton)
		rigidbody.position = Vector2(randf_range(-50,50),randf_range(-50,50))
		proton.position = Vector2(0,0)
		nuclei_folder.add_child(rigidbody)
