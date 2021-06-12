extends KinematicBody2D


var velocity : Vector2
var input_vector : Vector2
var max_speed := 1000
var friction := 0.3 # 0.2
var acceleration := 1500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if input_vector == Vector2.ZERO:
		velocity = velocity.linear_interpolate(Vector2.ZERO, friction)
	else:
		velocity += input_vector * acceleration * delta
		velocity = velocity.clamped(max_speed)
	
	velocity = move_and_slide(velocity)
