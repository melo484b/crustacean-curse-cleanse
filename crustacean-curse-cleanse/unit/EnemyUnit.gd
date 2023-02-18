class_name EnemyUnit
extends Unit


signal enemy_died(enemy_position)


const EVIL_MODULATION: String = "#820000"

var health_bar: CenterContainer
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

onready var loot: PackedScene = preload("res://loot/Loot.tscn")
onready var weapon_node: Node2D = $UnitWeaponNode
onready var target: Vector2 = position


func _init():
	speed = 100


func _on_ready() -> void:
	health_bar = $HealthBar
	animation.modulate = EVIL_MODULATION
	yield(get_tree().root, "ready")
	weapon_node.equip_enemy_weapon()


func move() -> void:
	var direction = get_player_direction()
	if direction.length() > NORMALIZED_MOVEMENT:
		direction = direction.normalized()
	if direction != Vector2.ZERO:
		current_state = STATE.MOVING
	else:
		current_state = STATE.IDLE
	var target_velocity: Vector2 = direction * speed
	velocity += (target_velocity - velocity) * friction
	velocity = move_and_slide(velocity)


func get_player_direction() -> Vector2:
	return target - position


func set_target(new_target_position: Vector2) -> void:
	target = new_target_position


func attack() -> void:
	# TODO: Attack logic
	pass


func get_hurt(damage: float) -> void:
	# TODO: Hurt sfx
	current_state = STATE.HURTING
	health_bar.take_damage(damage)


func spawn_loot() -> void:
	var loot_instance: Node2D = loot.instance()
	get_parent().add_child(loot_instance)
	loot_instance.position = position


func die() -> void:
	emit_signal("enemy_died", position)
	spawn_loot()
	call_deferred("queue_free")


func _on_HealthBar_empty() -> void:
	call_deferred("die")


func _on_PlayerDetection_body_entered(body) -> void:
	health_bar.visible = true
	set_target(body.position)


func _on_PlayerDetection_body_exited(body) -> void:
	set_target(body.position)
	health_bar.visible = false
