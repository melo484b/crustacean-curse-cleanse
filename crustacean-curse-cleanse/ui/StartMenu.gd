extends CanvasLayer


signal start_the_game


func _on_StartGame_pressed():
	emit_signal("start_the_game")
	queue_free()


func _on_Quit_pressed():
	get_tree().quit()
