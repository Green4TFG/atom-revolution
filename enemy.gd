extends RigidBody2D

const ELECTRON_VISUAL = preload("uid://bgah8wptarpd")
@onready var electron_folder: Node2D = $"electron folder"


@export var ring_counts = [2,8]
var total_electrons = ring_counts.reduce(sum, 0)
var rings = 0


func _ready() -> void:
	total_electrons = ring_counts.reduce(sum, 0)
	for electron_num in total_electrons+1:
		var electron = ELECTRON_VISUAL.instantiate()
		rings = Globals.find_ring(electron_num)
		electron.global_position = global_position
		electron.ring = rings
		electron.true_number = electron_num
		electron.number = electron_num - 1 - ((ring_counts.slice(0,rings - 1)).reduce(sum,0)  if rings > 0 else 0)
		electron.calc_vector()
	
		electron_folder.add_child(electron)
		update_electrons()

func update_electrons():
	for child in electron_folder.get_children():
		child.calc_vector()

		
func sum(accum, number):
	return accum + number
