class_name EnemyUnit
extends Unit


signal enemy_died(enemy_position)


const EVIL_MODULATION: String = "#820000"

var health_bar: CenterContainer


func _physics_process(_delta) -> void:
	move()


func _on_ready() -> void:
	health_bar = $HealthBar
	animation.modulate = EVIL_MODULATION


func move() -> void:
	# TODO
	pass


func find_player() -> void:
	var player: KinematicBody2D = get_tree().find_node("PlayerUnit")
	print(player.name)


func attack() -> void:
	# TODO: Attack logic
	pass


func get_hurt(damage: float) -> void:
	# TODO: Hurt sfx
	current_state = STATE.HURTING
	health_bar.take_damage(damage)


func die() -> void:
	emit_signal("enemy_died", position)
	queue_free()


func _on_HealthBar_empty() -> void:
	die()
