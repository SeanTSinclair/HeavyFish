extends Node2D

onready var high_scores = preload("res://highscores.tres")
onready var walls : Array = [$Wall, $Wall2, $Wall3, $Wall4, $Wall5]
onready var ui = $UI

var score = 0

func _ready():
	for wall in walls:
		wall.connect("score", self, "add_score")
		
func add_score():
	score += 1
	ui.set_score(score)

func save():
	high_scores.add_score(score)
	
func pause():
	for wall in walls:
		wall.paused(true)

func unpause():
	for wall in walls:
		wall.paused(false)

func _on_Fish_dead():
	pause()
	save()
	ui.game_over(score, high_scores.high_score())

func new_game():
	get_tree().reload_current_scene()
