extends Area2D

var tile_size = 64
var move_delay = 0.25
var anim_speed = 5
var inputs = {"right": Vector2.RIGHT,
		"left": Vector2.LEFT,
		"up": Vector2.UP,
		"down": Vector2.DOWN,
		"none": Vector2.ZERO}
		
var moving := false
var move_current_dir = "none"
var delta_time = 0
# Called when the node enters the scene tree for the first time.
#func _ready():
	# position = position.snapped(Vector2.ONE * tile_size)

func _unhandled_input(event: InputEvent):
	var multi_pressed = 0
	var movedir = "none"
	# add 1 every time an input is pressed, if larger than 1 don't do anything.
	for dir in inputs.keys():
		if multi_pressed > 1:
			return
		if Input.is_action_just_pressed(dir):
			multi_pressed += 1
			movedir = dir
	if multi_pressed == 1:
		start_moving(movedir)
		
func start_moving(action):
	if moving:
		return
	else:
		moving = true
		delta_time = 0
		move_current_dir = action
		move_player(inputs[action] * tile_size)
	
func move_player(rel_position):
	position += rel_position
		
func _process(delta):
	if moving:
		delta_time += delta
		$Label.text = str(delta_time)
		if delta_time > move_delay:
			delta_time = 0
			if Input.is_action_pressed(move_current_dir):
				move_player(inputs[move_current_dir] * tile_size)
			else:
				moving = false
				move_current_dir = "none"
