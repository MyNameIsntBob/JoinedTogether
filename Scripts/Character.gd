extends KinematicBody2D


var velocity : Vector2
var input_vector : Vector2
var max_speed := 100
var friction := 0.3 # 0.2
var acceleration := 1500

func _process(delta):
	
	if input_vector == Vector2.ZERO:
		velocity = velocity.linear_interpolate(Vector2.ZERO, friction)
	else:
		velocity += input_vector * acceleration * delta
		velocity = velocity.clamped(max_speed)
	
	velocity = move_and_slide(velocity, Vector2.ZERO, false, 4, 0.785398, false)
	
	if input_vector != Vector2.ZERO:
		if input_vector.x > 0:
			$Sprite.flip_h = true
			
		if input_vector.x < 0:
			$Sprite.flip_h = false
		
		if $AnimationPlayer.current_animation != 'walk':
			$AnimationPlayer.stop()
			$AnimationPlayer.play("walk")
	else:
		if $AnimationPlayer.current_animation != 'idle':
			$AnimationPlayer.stop()
			$AnimationPlayer.play("idle")
