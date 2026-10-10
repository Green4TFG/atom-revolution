extends Node


var player
var rings = 0.0

const RING_SUMS = [2, 10, 18, 36, 54, 86, 118]

func find_ring(electron_num: float):
	for i in RING_SUMS.size() :
		if(electron_num - RING_SUMS[i] < 1):
			return float(i) 
