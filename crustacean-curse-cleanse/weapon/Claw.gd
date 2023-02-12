extends Weapon


onready var collider: CollisionShape2D = $Area2D/CollisionShape2D
onready var animation: AnimatedSprite = $ClawAttackAnimationSprite


func _init() -> void:
	damage = 35
	knockback = 5


func attack() -> void:
	update_direction()
	animation.frame = 0
	animation.playing = true


func _on_ClawAttackAnimationSprite_attack_frame() -> void:
	collider.disabled = false


func _on_ClawAttackAnimationSprite_animation_finished() -> void:
	collider.disabled = true


func _on_Timer_timeout():
	attack()