extends Node


var player_camera = null
var cutscene_camera = null
const RING_SIZE = 30
const FIRST_RING = 40

var player
var target
var rings = 0.0
var time = 90
var winner = ""

const CUTSCENE = preload("uid://bhlww2nal8pd5")

const ELECTRON_COUNTS = [[2],[2,8],[2,8,8],[2,8,18,8],[2,8,18,18,8],[2,8,18,32,18,8],[2,8,18,32,32,18,8]]


var ELEMENT = 3 #1 is Helium, 5 is Radon
var RING_COUNTS = ELECTRON_COUNTS[ELEMENT-1]
var RING_SUMS = []
var needed

func _ready() -> void:
	for i in RING_COUNTS.size() :
		RING_SUMS.append( RING_COUNTS.slice(0,i+1).reduce(sum,0))

func electron_steal(electron: electron_visual):
	get_tree().paused = true
	CameraTransition.transition(player_camera, electron.camera)
	await CameraTransition.tween.finished
	var cutscene = CUTSCENE.instantiate()
	cutscene.electron_parent = electron.get_parent().get_parent()
	add_sibling(cutscene)
	cutscene.z_index = 100
	await cutscene.finished
	print(winner)
	get_tree().paused = false
	if(winner == "player"):
		print("yay")
		player.add_electron()
		electron.get_parent().get_parent().lose_electron()
	elif(winner == "enemy"):
		print("no")
		player.lose_electron()
		electron.get_parent().get_parent().add_electron()
	get_tree().paused = true
	CameraTransition.transition(electron.camera, player_camera)
	get_tree().paused = false
	


func find_ring(electron_num: float,ring_array):
	for i in ring_array.size() :
		if(electron_num - ring_array[i] < 1):
			return float(i) 

func sum(accum, number):
	return accum + number

func set_level(element):
	ELEMENT = element
	RING_COUNTS = ELECTRON_COUNTS[ELEMENT-1]
	needed = RING_SUMS[element]
