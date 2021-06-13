extends Node2D

var shoot_dir : Vector2
export var shoot_speed : float 

var capturing := false

onready var BUBBLE = preload('res://Prefabs/Bubble.tscn')

var persons := []

func _ready():
	shoot_dir = shoot_dir.normalized()
	if shoot_dir != Vector2.ZERO:
		$Ball1.linear_velocity = (shoot_dir * shoot_speed) + (rotate_vel(shoot_dir, -(PI / 2)) * shoot_speed)
		$Ball2.linear_velocity = (shoot_dir * shoot_speed) + (rotate_vel(shoot_dir, (PI / 2)) * shoot_speed)
#		$Ball1.add_central_force(rotate_vel(shoot_dir, -(PI / 2)) * 1000)
#		$Ball2.add_central_force(rotate_vel(shoot_dir, (PI / 2)) * 1000)
#		$Ball1.add_central_force(shoot_dir * shoot_speed / 2)
#		$Ball2.add_central_force(shoot_dir * shoot_speed)

func _process(delta):
	$Ball1.add_central_force(shoot_dir * delta * 10)
	$Ball2.add_central_force(shoot_dir * delta * 10)

func add_person(obj):
	if len(persons) == 0:
		start_capture()
	persons.append(obj)
	
func remove_person(obj):
	if obj in persons:
		persons.erase(obj)

func start_capture():
	if capturing:
		return
	capturing = true
	$KillTimer.stop()
	$CaptureTimer.start()

func rotate_vel(velocity, angle):
	var new_velocity = Vector2.ZERO
	new_velocity.x = (velocity.x * cos(angle) - velocity.y * sin(angle))
	new_velocity.y = (velocity.x * sin(angle) + velocity.y * cos(angle))
	return new_velocity

func _on_CaptureTimer_timeout():
	if len(persons) == 0:
		self.queue_free()
		return
	
	var type = 0
	if len(persons) == 1:
		type = 1
	else:
		var gender = -1
		var is_gay = true
		for p in persons:
			if gender == -1:
				gender = p.gender
			else:
				if gender != p.gender:
					is_gay = false
		if is_gay:
			type = 2
	
	var bubble = BUBBLE.instance()
	bubble.type = type
	get_parent().add_child(bubble)
	bubble.global_position = persons[0].global_position
	
	Global.add_points(len(persons))
	for p in persons:
		if is_instance_valid(p):
			p.queue_free()
	self.queue_free()

func _on_KillTimer_timeout():
	self.queue_free()

func queue_free():
	.queue_free()
