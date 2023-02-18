extends CanvasLayer


signal player_death
signal game_time_up


onready var health_bar: CenterContainer = $HealthBar


func reduce_health_bar(damage: float) -> void:
	health_bar.take_damage(damage)


func _on_HealthBar_empty():
	emit_signal("player_death")


func _on_GameTimer_time_exhausted():
	emit_signal("game_time_up")
