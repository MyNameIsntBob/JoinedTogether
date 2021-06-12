extends Node2D

var shoot_dir : Vector2
export var shoot_speed : float 

var persons := []

func _ready():
	shoot_dir = shoot_dir.normalized()
	if shoot_dir != Vector2.ZERO:
		$Ball1.linear_velocity = shoot_dir * shoot_speed
		$Ball2.linear_velocity = shoot_dir * shoot_speed
		$Ball1.add_central_force(rotate_vel(shoot_dir, -(PI / 2)) * 20)
		$Ball2.add_central_force(rotate_vel(shoot_dir, (PI / 2)) * 20)
#		$Ball1.add_central_force(shoot_dir * shoot_speed / 2)
#		$Ball2.add_central_force(shoot_dir * shoot_speed)

func add_person(obj):
	if len(persons) == 0:
		start_capture()
	persons.append(obj)

func start_capture():
	$KillTimer.stop()
	$CaptureTimer.start()

func rotate_vel(velocity, angle):
	var new_velocity = Vector2.ZERO
	new_velocity.x = (velocity.x * cos(angle) - velocity.y * sin(angle))
	new_velocity.y = (velocity.x * sin(angle) + velocity.y * cos(angle))
	return new_velocity

func _on_CaptureTimer_timeout():
	Global.add_points(len(persons))
	for p in persons:
		if is_instance_valid(p):
			p.queue_free()
	self.queue_free()

func _on_KillTimer_timeout():
	self.queue_free()

func queue_free():
	if len(get_tree().get_nodes_in_group("NPC")):
		Global.game_over()
	.queue_free()
