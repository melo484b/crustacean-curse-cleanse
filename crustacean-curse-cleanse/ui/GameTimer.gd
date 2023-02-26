extends Label


signal time_exhausted


var game_time: int = 60


func start() -> void:
# warning-ignore:narrowing_conversion
	game_time *= PlayerData.get_time_modifier()
	update_text()
	$Timer.start()


func stop() -> void:
	$Timer.stop()


func update_text() -> void:
	text = str(game_time)


func set_game_time(new_time: int) -> void:
	game_time = new_time


func get_game_time() -> int:
	return game_time


func _on_Timer_timeout() -> void:
	if game_time > 0:
		game_time -= 1
	else:
		$Timer.stop()
		emit_signal("time_exhausted")
	update_text()
