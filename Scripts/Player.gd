extends 'res://Scripts/Character.gd'


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var BULLETS = preload("res://Prefabs/Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	print(rotation)
	
	input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	look_at(get_global_mouse_position())

	if Input.is_action_just_pressed("fire"):
		fire()

func fire():
	var bul = BULLETS.instance()
	bul.rotation = self.rotation + (PI * 0.5)
	bul.shoot_dir = get_global_mouse_position() - self.global_position
	bul.position = self.position
	get_parent().add_child(bul)
