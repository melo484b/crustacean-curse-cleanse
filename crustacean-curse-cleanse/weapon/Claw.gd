extends Node2D


var damage: int = 35
var knockback: int = 5

onready var collider: CollisionShape2D = $Area2D/CollisionShape2D
onready var animation: AnimatedSprite = $ClawAttackAnimationSprite


func attack() -> void:
	update_direction()
	animation.frame = 0
	animation.playing = true


func get_direction_in_degrees() -> float:
	var direction: Vector2 = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"), 
		Input.get_action_strength("down") - Input.get_action_strength("up")
		)
	var look_target: Vector2 = position.direction_to(direction) * -1
	return atan2(look_target.y, look_target.x) / PI * 180.0


func update_direction() -> void:
	rotation_degrees = get_direction_in_degrees()


func _on_ClawAttackAnimationSprite_attack_frame() -> void:
	collider.disabled = false


func _on_ClawAttackAnimationSprite_animation_finished() -> void:
	collider.disabled = true


func _on_Timer_timeout():
	attack()
