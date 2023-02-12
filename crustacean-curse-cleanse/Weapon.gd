class_name Weapon
extends Node2D

var damage: int = 0
var knockback: int = 0
var previous_direction: Vector2 = Vector2()

func attack() -> void:
	pass


func get_direction_in_degrees() -> float:
	var direction: Vector2 = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"), 
		Input.get_action_strength("down") - Input.get_action_strength("up")
		)
	if direction == Vector2(0, 0):
		direction = previous_direction
	else:
		previous_direction = direction
	var look_target: Vector2 = position.direction_to(direction) * -1
	return atan2(look_target.y, look_target.x) / PI * 180.0


func update_direction() -> void:
	rotation_degrees = get_direction_in_degrees()
