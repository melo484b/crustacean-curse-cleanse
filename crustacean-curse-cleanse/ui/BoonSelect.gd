extends CanvasLayer


signal boon_confirmed


var selected: int = 0

onready var boon_buttons: HBoxContainer = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/BoonButtons


func uncheck_other_buttons(button_name: String) -> void:
	for button in boon_buttons.get_children():
		if button.name != button_name:
			button.pressed = false


func _on_Boon1_pressed() -> void:
	$PressSFX.play()
	selected = 0
	uncheck_other_buttons("Boon1")


func _on_Boon2_pressed() -> void:
	$PressSFX.play()
	selected = 1
	uncheck_other_buttons("Boon2")


func _on_Boon3_pressed() -> void:
	$PressSFX.play()
	selected = 2
	uncheck_other_buttons("Boon3")


func _on_Confirm_Button_pressed() -> void:
	$PressSFX.play()
	PlayerData.set_boon_selection(selected)
	emit_signal("boon_confirmed")
	yield($PressSFX, "play_complete")
	call_deferred("queue_free")


func _on_Boon1_mouse_entered() -> void:
	$HoverSFX.play()


func _on_Boon2_mouse_entered() -> void:
	$HoverSFX.play()


func _on_Boon3_mouse_entered() -> void:
	$HoverSFX.play()


func _on_ConfirmButton_mouse_entered() -> void:
	$HoverSFX.play()
