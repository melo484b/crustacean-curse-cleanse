class_name PlayerUnit
extends Unit


func _init() -> void:
# warning-ignore:narrowing_conversion
	health *= PlayerData.get_health_modifier()
	friction *= PlayerData.get_connection()


func _on_ready() -> void:
	$UnitWeaponNode.equip_player_weapon()


func move() -> void:
	var direction: Vector2 = get_input_direction()
	if direction.length() > NORMALIZED_MOVEMENT:
		direction = direction.normalized()
	if direction != Vector2.ZERO:
		moving = true
	else:
		moving = false
	var target_velocity: Vector2 = direction * speed
	_velocity += (target_velocity - _velocity) * friction
	_velocity = move_and_slide(_velocity)
