extends Node


var player
var rings = 0.0

var RING_COUNTS = [2, 8, 18, 8] #UPDATE THIS BASED ON DIFFICULTY
var ELEMENT = 4 #1 is Helium, 5 is Radon

var RING_SUMS = []

func _ready() -> void:
	for i in RING_COUNTS.size() :
		RING_SUMS.append( RING_COUNTS.slice(0,i+1).reduce(sum,0))
	
	
func find_ring(electron_num: float):
	for i in RING_SUMS.size() :
		if(electron_num - RING_SUMS[i] < 1):
			return float(i) 

func element():
	return ELEMENT

func sum(accum, number):
	return accum + number
