class_name EnemyUnit
extends Unit


signal enemy_died(enemy_position)


const EVIL_MODULATION: String = "#820000"

var health_bar: CenterContainer
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

onready var loot: PackedScene = preload("res://loot/Loot.tscn")
onready var weapon_node: Node2D = $UnitWeaponNode
onready var target: KinematicBody2D = self


func _init() -> void:
	speed = 5500.0


func _on_ready() -> void:
	health_bar = $HealthBar
	animation.modulate = EVIL_MODULATION


func move(delta: float) -> void:
	var direction = get_player_direction()
	if direction.length() > NORMALIZED_MOVEMENT:
		direction = direction.normalized()
	if direction != Vector2.ZERO:
		current_state = STATE.MOVING
	else:
		current_state = STATE.IDLE
	var target_velocity: Vector2 = direction * speed * delta
	velocity += (target_velocity - velocity) * friction
	velocity = move_and_slide(velocity)


func get_player_direction() -> Vector2:
	return (target.get_global_position() - get_global_position())


func set_target(new_target: KinematicBody2D) -> void:
	target = new_target


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
	call_deferred("set_target", body)


func _on_PlayerDetection_body_exited(_body) -> void:
	weapon_node.deactivate()
	call_deferred("set_target", self)
	health_bar.visible = false
