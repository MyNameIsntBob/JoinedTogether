extends Node

var score := 0
var is_game_over := false
var highscore := 0

func game_over():
	is_game_over = true

func add_points(amount):
	if amount == 0:
		return
		
	if amount == 1:
		score -= 1
		return
		
	if amount == 2:
		score += 3
		return
	
	amount += amount
