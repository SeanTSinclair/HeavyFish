extends Control

onready var score = $Score

onready var game_over_score = $GameOver/ScoreContainer/Score/Value
onready var game_over_highscore = $GameOver/ScoreContainer/HighScore/Value

func set_score(value):
	score.text = str(value)
	
func game_over(score, highscore):
	game_over_score.text = str(score)
	game_over_highscore.text = str(highscore)
	$GameOver.visible = true

