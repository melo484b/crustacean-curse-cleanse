extends CanvasLayer


signal start_the_game


func _on_StartGame_pressed() -> void:
	$PressSFX.play()
	emit_signal("start_the_game")
	yield($PressSFX, "play_complete")
	call_deferred("queue_free")


func _on_Quit_pressed() -> void:
	$PressSFX.play()
	yield($PressSFX, "play_complete")
	get_tree().quit()


func _on_StartGame_mouse_entered() -> void:
	$HoverSFX.play()


func _on_Quit_mouse_entered() -> void:
	$HoverSFX.play()
