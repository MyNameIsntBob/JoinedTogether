extends CanvasLayer

export (NodePath) var score
export (NodePath) var end_label
export (NodePath) var highscore
export (NodePath) var time
export (NodePath) var time2

var end_text = {
	2: "Ouch, that's just sad",
	5: "Some love in the air. Not Much though",
	10: 'Love',
	20: "Love is flying.",
	999: 'Mega love bomb'
}

func _ready():
	time = get_node(time)
	time2 = get_node(time2)
	score = get_node(score)
	highscore = get_node(highscore)
	end_label = get_node(end_label)
	
func _process(_delta):
	$GameOverScreen.visible = Global.is_game_over
	
	if time:
		time.text = str(int(Global.time_left))
	
	if time2:
		time2.text = str(int(Global.time_left))
	
	if score:
		score.text = str(Global.score)
	
	if highscore:
		highscore.text = "HighScore: " + str(Global.highscore)
		
	if end_label and Global.is_game_over:
		end_label.text =  get_end_text() + "\n\n You got " + str(Global.score) + " love."
		
func get_end_text():
	for k in end_text.keys():
		if Global.score < k:
			return end_text[k]
	return "So much love that you broke something."


func _on_Button_pressed():
	Global.restart()
