extends CanvasLayer


var selected: int = 0

onready var boon_buttons: HBoxContainer = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/BoonButtons


func uncheck_other_buttons(button_name: String) -> void:
	for button in boon_buttons.get_children():
		if button.name != button_name:
			button.pressed = false


func _on_Boon1_pressed() -> void:
	selected = 0
	uncheck_other_buttons("Boon1")


func _on_Boon2_pressed() -> void:
	selected = 1
	uncheck_other_buttons("Boon2")


func _on_Boon3_pressed() -> void:
	selected = 2
	uncheck_other_buttons("Boon3")


func _on_Confirm_Button_pressed() -> void:
	# TODO: Start game
	PlayerData.set_boon_selection(selected)
	print(PlayerData.get_boon_selection())
