extends 'res://Scripts/Character.gd'

var wait_time = 3.0
var wait_range = 1.0

var captured := false


enum genders {
	Male,
	Female
}
export (genders) var gender 

func _ready():
	if gender == genders.Female:
#		$Sprite.modulate = new Color(1, 0, 0)
		$Sprite.modulate = Color(1, 0, 0)
		pass
	randomize()
	_on_WanderTimer_timeout()

func change_wander_direction():
	input_vector = Vector2(rand_range(-1, 1), rand_range(-1, 1))

func _on_WanderTimer_timeout():
	$WanderTimer.wait_time = rand_range(wait_time - wait_range, wait_time + wait_range)
	change_wander_direction()

func _on_Area2D_body_entered(body):
	if captured:
		return
	var bul = body.find_parent('Bullet')
	if bul:
		$WanderTimer.stop()
		input_vector = Vector2.ZERO
		captured = true
		bul.add_person(self)
