class_name EnemyUnit
extends Unit


signal enemy_died(enemy_position)


const EVIL_MODULATION: String = "#820000"

var health_bar: CenterContainer
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

onready var loot: PackedScene = preload("res://loot/Loot.tscn")
onready var weapon_node: Node2D = $UnitWeaponNode
onready var target: Vector2 = position


func _init() -> void:
	speed = 100


func _on_ready() -> void:
	health_bar = $HealthBar
	animation.modulate = EVIL_MODULATION


func move() -> void:
	$MoveSFXmanager.play()
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
	# Currently handled in weapon script
	pass


func get_hurt(damage: float) -> void:
	$HurtSFXmanager.play()
	current_state = STATE.HURTING
	health_bar.take_damage(damage)


func spawn_loot() -> void:
	var loot_instance: Node2D = loot.instance()
	get_parent().add_child(loot_instance)
	loot_instance.position = position


func die() -> void:
	$DeathSFXmanager.play()
	emit_signal("enemy_died", position)
	spawn_loot()
	# TODO: Replace with sick animation
	visible = false
	yield($DeathSFXmanager, "play_complete")
	call_deferred("queue_free")


func _on_HealthBar_empty() -> void:
	call_deferred("die")


func _on_PlayerDetection_body_entered(body) -> void:
	weapon_node.activate()
	health_bar.visible = true
	call_deferred("set_target", body.position)


func _on_PlayerDetection_body_exited(body) -> void:
	weapon_node.deactivate()
	call_deferred("set_target", body.position)
	health_bar.visible = false
