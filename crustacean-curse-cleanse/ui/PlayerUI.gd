extends CanvasLayer


signal player_death
signal game_time_up


onready var health_bar: CenterContainer = $HealthBar
onready var wealth_count: Label = $WealthCount


func reduce_health_bar(damage: float) -> void:
	health_bar.take_damage(damage)


func pick_up_loot(loot_value: int) -> void:
	wealth_count.animated_increase(loot_value)


func _on_HealthBar_empty():
	emit_signal("player_death")


func _on_GameTimer_time_exhausted():
	emit_signal("game_time_up")
