extends Node

var score := 0
var is_game_over := false
var highscore := 0

func game_over():
	if score > highscore:
		highscore = score
	is_game_over = true

func restart():
	score = 0
	is_game_over = false
	get_tree().reload_current_scene()

func add_points(amount):
	if amount == 0:
		return
		
	if amount == 1:
		score -= 1
		return
		
	if amount == 2:
		score += 3
		return
	
	score += amount

const art = {
	0: preload('res://Art/Characters_0000_Guy.png'),
	1: preload('res://Art/Characters_0002_Girl.png')
}

func get_character(char_id):
	return art[char_id]
