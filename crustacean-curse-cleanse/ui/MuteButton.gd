extends MarginContainer


var on: Texture = load("res://art/audio_on.png")
var off: Texture = load("res://art/audio_off.png")
var master_sound = AudioServer.get_bus_index("Master")

onready var button: Button = $PanelContainer/MarginContainer/Button


func _on_Button_toggled(button_pressed) -> void:
	if button_pressed:
		button.icon = on
		AudioServer.set_bus_mute(master_sound, false)
	else:
		button.icon = off
		AudioServer.set_bus_mute(master_sound, true)
