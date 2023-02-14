extends CanvasLayer


signal player_death


onready var health_bar: CenterContainer = $HealthBar


func reduce_health_bar(damage: float) -> void:
	health_bar.take_damage(damage)


func _on_HealthBar_empty():
	emit_signal("player_death")
