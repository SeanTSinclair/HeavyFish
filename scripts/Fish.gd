extends KinematicBody2D

signal dead

const MAX_ROTATION_DEGREES : int = 50
const ROTATION_SPEED : float = .1

export var swim_height : float
export var time_to_reach_peak : float
export var time_to_descent : float

onready var swim_velocity : float = ((2.0 * swim_height) / time_to_reach_peak) * -1.0
onready var swim_gravity : float = ((-2.0 * swim_height) / (time_to_reach_peak * time_to_reach_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * swim_height) / (time_to_reach_peak * time_to_reach_peak)) * -1.0
onready var screen_height = get_viewport().size.y
onready var sprite = $AnimatedSprite

var velocity : Vector2 = Vector2.ZERO
var is_dead : bool = false

func _physics_process(delta):
	if is_dead:
		move_and_slide(Vector2.UP * (swim_gravity / 10))
		return 
	
	velocity.y += get_gravity() * delta
	
	if Input.is_action_just_pressed("swim"):
		swim()
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if get_slide_count() > 0:
		die()
	
	position.y = clamp(position.y, 0, screen_height + 50)
	apply_rotation()

func get_gravity() -> float:
	return swim_gravity if velocity.y < 0.0 else fall_gravity

func swim() -> void: 
	velocity.y = swim_velocity

func apply_rotation():
	var rotation_degrees : float = clamp(velocity.y, -MAX_ROTATION_DEGREES, MAX_ROTATION_DEGREES)
	sprite.rotation_degrees = lerp(sprite.rotation_degrees, rotation_degrees, ROTATION_SPEED)

func die() -> void:
	is_dead = true
	$CollisionShape2D.disabled = true
	sprite.animation = "dead"
	emit_signal("dead")
