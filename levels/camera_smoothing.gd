extends Camera2D

@onready var player: CharacterBody2D = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var weight = 1.0 - exp(-20 * delta)
	global_position = lerp(player.global_position, get_global_mouse_position(), weight)
