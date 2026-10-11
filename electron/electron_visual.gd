class_name electron_visual

extends Sprite2D

@onready var hitbox: Area2D = $hitbox
@onready var bar: TextureProgressBar = $TextureProgressBar

const INCREMENT_SPEED = 1

var parent = null
var ring = 0;
var true_number = 0;
var number = 0;
var rot_speed = 1;
var myVector = Vector2(0,0)
var increment = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func calc_vector():
	var distance = (ring+1)*(Globals.RING_SIZE) + Globals.FIRST_RING
	var section_size = (2 * PI)/parent.ring_counts[ring]
	myVector = Vector2(distance,0).rotated(section_size*(number))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	position = myVector.rotated(Globals.player.degrees/(ring+1))
	visible = true
	if(increment and Input.is_action_pressed("mouseleft") and ring == parent.ring_counts.size()-1):
		if(bar.value < bar.max_value):
			bar.value += INCREMENT_SPEED
		else:
			Globals.electron_steal(self)
	elif(bar.value > bar.min_value):
		bar.value -= INCREMENT_SPEED * 2
