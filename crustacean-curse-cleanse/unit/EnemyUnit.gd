class_name EnemyUnit
extends Unit


const EVIL_MODULATION: String = "#820000"

var health_bar: CenterContainer


func _physics_process(_delta) -> void:
	move()


func _on_ready() -> void:
	health_bar = $HealthBar
	animation.modulate = EVIL_MODULATION


func move() -> void:
	pass


func find_player() -> void:
	var player: KinematicBody2D = get_tree().find_node("PlayerUnit")
	print(player.name)


func attack() -> void:
	# TODO: Attack logic
	pass


func get_hurt(damage: float) -> void:
	# TODO: Hurt sfx
	health_bar.take_damage(damage)
	emit_signal("take_damage")
	animation.play("hurt")
