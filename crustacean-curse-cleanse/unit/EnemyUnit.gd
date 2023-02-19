class_name EnemyUnit
extends Unit


signal enemy_died(enemy_position)


const EVIL_MODULATION: String = "#820000"
const SPEED_MODIFIER: float = 1.5

var health_bar: CenterContainer
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var has_vision_of_player: bool = false
var previous_target_location: Vector2

onready var loot: PackedScene = preload("res://loot/Loot.tscn")
onready var weapon_node: Node2D = $UnitWeaponNode
onready var target: KinematicBody2D = self


func _init() -> void:
	speed = 3666.66


func _on_ready() -> void:
	rng.randomize()
	health_bar = $HealthBar
	animation.modulate = EVIL_MODULATION
	previous_target_location = generate_random_target()


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
	if has_vision_of_player:
		return (target.get_global_position() - get_global_position())
	else:
		return (previous_target_location - get_global_position())


func generate_random_target() -> Vector2:
	var x_pos: float = rng.randf_range(64, 960)
	var y_pos: float = rng.randf_range(64, 536)
	return Vector2(x_pos, y_pos)


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
	speed *= SPEED_MODIFIER
	has_vision_of_player = true
	weapon_node.activate()
	health_bar.visible = true
	call_deferred("set_target", body)


func _on_PlayerDetection_body_exited(_body) -> void:
	speed /= SPEED_MODIFIER
	previous_target_location = target.get_global_position()
	has_vision_of_player = false
	weapon_node.deactivate()
	health_bar.visible = false


func _on_BoredTimer_timeout() -> void:
	$BoredTimer.wait_time = rng.randi_range(3, 6)
	if !has_vision_of_player:
		previous_target_location = generate_random_target()
