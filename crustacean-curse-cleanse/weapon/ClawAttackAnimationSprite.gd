extends AnimatedSprite


signal attack_frame


func _on_ClawAttackAnimationSprite_frame_changed() -> void:
	if frame == 3:
		emit_signal("attack_frame")
