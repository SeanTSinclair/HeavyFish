extends Node2D

signal score

export var speed : float = 125.0

onready var sfx = $AudioStreamPlayer2D

func _ready():
	move_to_random_vertical_position()

func _physics_process(delta):
	position += Vector2.LEFT * speed * delta

func paused(pause):
	set_physics_process(!pause)
	
func move_to_random_vertical_position():
	position.y = rand_range(-100, 200)
	
func _on_ScoreBox_body_entered(body):
	emit_signal("score")
	sfx.play()
