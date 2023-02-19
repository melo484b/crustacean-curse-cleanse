class_name PlayerUnit
extends Unit


var player_vision: Light2D


func _init() -> void:
# warning-ignore:narrowing_conversion
	health *= PlayerData.get_health_modifier()
	friction *= PlayerData.get_connection()


func _on_ready() -> void:
	$UnitWeaponNode.equip_player_weapon()
	player_vision = $PlayerVision
	player_vision.scale *= PlayerData.get_vision()


func move(delta: float) -> void:
	var direction: Vector2 = get_input_direction()
	if direction.length() > NORMALIZED_MOVEMENT:
		direction = direction.normalized()
	if direction != Vector2.ZERO:
		current_state = STATE.MOVING
	else:
		current_state = STATE.IDLE
	var target_velocity: Vector2 = direction * speed * delta
	velocity += (target_velocity - velocity) * friction
	velocity = move_and_slide(velocity)
