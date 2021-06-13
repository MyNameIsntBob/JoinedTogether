extends Node

var score := 0
var is_game_over := false
var highscore := 0

var number_of_bots : int

var time_left : float

func _ready():
	number_of_bots = len(get_tree().get_nodes_in_group("NPC"))

func game_over():
	get_tree().paused = true
	if score > highscore:
		highscore = score
	is_game_over = true

func restart():
	get_tree().paused = false
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
	0: preload('res://Art/GuySpriteSheet.png'),
	1: preload('res://Art/GirlSpriteSheet.png'),
	'bubble':{
		0: preload("res://Art/Love_0005_Layer-3.png"),
		1: preload("res://Art/Alone_0006_download.png"),
		2: preload("res://Art/rainbow_0006_Layer-12.png")
	}
}

func get_character(char_id):
	return art[char_id]
	
func get_bubble(type):
	return art["bubble"][type]
