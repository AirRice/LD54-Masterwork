extends Sprite2D

var speed = 400
var ang_speed = PI
func _init():
	print("Hello world")
	
func _process(delta):
	rotation += ang_speed * delta
