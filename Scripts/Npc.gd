extends 'res://Scripts/Character.gd'

var wait_time = 3.0
var wait_range = 1.0

var captured := false

var chains := []

var near_chains := []

var otherNPCs := []

enum genders {
	Male,
	Female
}
export (genders) var gender 

func _ready():
#	if gender == genders.Female:
#		$Sprite.modulate = new Color(1, 0, 0)
#		$Sprite.modulate = Color(1, 0, 0)
	$Sprite.texture = Global.get_character(gender)
	randomize()
	_on_WanderTimer_timeout()

func change_wander_direction():
	if captured:
		return
	
	input_vector = Vector2(rand_range(-1, 1), rand_range(-1, 1))
	if len(otherNPCs) != 0:
		otherNPCs.shuffle()
		input_vector = (input_vector + (otherNPCs[0].global_position - self.global_position)).normalized()
		
	if len(near_chains) != 0:
		near_chains.shuffle()
		input_vector = (input_vector + (self.global_position - near_chains[0].global_position)).normalized()
#	input_vector = (input_vector + other

func queue_free():
	if captured:
		.queue_free()
		
		if len(get_tree().get_nodes_in_group("NPC")) <= 0:
			Global.game_over()

func _on_WanderTimer_timeout():
	$WanderTimer.wait_time = rand_range(wait_time - wait_range, wait_time + wait_range)
	change_wander_direction()

func _on_Area2D_body_entered(body):
	chains.append(body)
	
	if captured:
		return
	var bul = body.find_parent('Bullet')
	if bul:
		$WanderTimer.stop()
		input_vector = Vector2.ZERO
		captured = true
		bul.add_person(self)


func _on_Area2D_body_exited(body):
	if body in chains:
		chains.erase(body)
	
	if len(chains) == 0:
		captured = false
		$WanderTimer.start()
		change_wander_direction()
		var bul = body.find_parent("Bullet")
		if bul:
			bul.remove_person(self)


func _on_NPCArea_body_entered(body):
	otherNPCs.append(body)


func _on_NPCArea_body_exited(body):
	if body in otherNPCs:
		otherNPCs.erase(body)


func _on_ChainChecker_body_entered(body):
	near_chains.append(body)
	change_wander_direction()


func _on_ChainChecker_body_exited(body):
	if body in near_chains:
		near_chains.erase(body)
