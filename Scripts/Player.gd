extends 'res://Scripts/Character.gd'

onready var BULLETS = preload("res://Prefabs/Bullet.tscn")

func _ready():
	max_speed = 1000

func _process(_delta):
	input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	$Aim.look_at(get_global_mouse_position())

	if Input.is_action_just_pressed("fire"):
		fire()
		
	if input_vector != Vector2.ZERO:
		$Tutorial/WASD.hide()

func fire():
	$Tutorial/LeftMouse.hide()
	
	if len(get_tree().get_nodes_in_group("Bullet")) != 0:
		return
		
	var bul = BULLETS.instance()
	bul.rotation = $Aim.rotation + (PI * 0.5)
	bul.shoot_dir = get_global_mouse_position() - self.global_position
	bul.position = $Aim/Position2D.global_position
	get_parent().add_child(bul)

