extends Node2D

var shoot_dir : Vector2
export var shoot_speed : float 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	shoot_dir = shoot_dir.normalized()
	if shoot_dir != Vector2.ZERO:
		$Ball1.add_central_force(shoot_dir * shoot_speed)
		$Ball2.add_central_force(shoot_dir * shoot_speed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	rotate(delta * 100)
#	pass
