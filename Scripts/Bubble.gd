extends Node2D

var type := 0

enum types {
	LOVE,
	ALONE,
	LGBT
}

# Called when the node enters the scene tree for the first time.
func _ready():
	print(type)
	$Sprite.texture = Global.get_bubble(type)
	
