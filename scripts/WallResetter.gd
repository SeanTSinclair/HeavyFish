extends Area2D

const RESET_POSITION : Vector2 = Vector2(1100, 100)

func _on_WallResetter_area_entered(area):
	area.owner.position = RESET_POSITION
	area.owner.move_to_random_vertical_position()
