extends CanvasLayer


signal contract_signed


const CURSED_VISION: float = 0.75
const CURSED_CONNECTION: float = 0.1
const CURSED_HEALTH_MODIFIER: float = 0.5
const CURSED_LUCK: float = 0.5
const CURSED_TIME_MODIFIER: float = 0.5
const INITIAL_WEALTH_MULTIPLIER: float = 1.0
const BONUS_MULTIPLIER: float = 1.5

var vision_cursed: bool = false
var connection_cursed: bool = false
var health_cursed: bool = false
var luck_cursed: bool = false
var time_cursed: bool = false
var calculated_wealth_multiplier: float = 1.0

onready var wealth_multiplier_label: Label = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/Wealth_Multiplier/PanelContainer/MarginContainer/CenterContainer/HBoxContainer/Multiplier_Label


func curse_vision() -> void:
	PlayerData.set_vision(CURSED_VISION)


func curse_connection() -> void:
	PlayerData.set_connection(CURSED_CONNECTION)


func curse_health() -> void:
	PlayerData.set_health_modifier(CURSED_HEALTH_MODIFIER)


func curse_luck() -> void:
	PlayerData.set_health_modifier(CURSED_HEALTH_MODIFIER)


func curse_time_modifier() -> void:
	PlayerData.set_time_modifier(CURSED_TIME_MODIFIER)


func apply_curses() -> void:
	if vision_cursed:
		curse_vision()
	if connection_cursed:
		curse_connection()
	if health_cursed:
		curse_health()
	if luck_cursed:
		curse_luck()
	if time_cursed:
		curse_time_modifier()


func update_wealth_multiplier_label() -> void:
	wealth_multiplier_label.text = str(calculated_wealth_multiplier)


func increase_wealth_multiplier() -> void:
	calculated_wealth_multiplier = stepify(calculated_wealth_multiplier * BONUS_MULTIPLIER, 0.01)
	update_wealth_multiplier_label()


func decrease_wealth_multiplier() -> void:
	calculated_wealth_multiplier = stepify(calculated_wealth_multiplier / BONUS_MULTIPLIER, 0.01)
	update_wealth_multiplier_label()


func _on_Vision_Button_pressed() -> void:
	$PressSFX.play()
	yield($PressSFX, "play_complete")
	if vision_cursed:
		vision_cursed = false
		decrease_wealth_multiplier()
	else:
		vision_cursed = true
		increase_wealth_multiplier()


func _on_Connection_Button_pressed() -> void:
	$PressSFX.play()
	yield($PressSFX, "play_complete")
	if connection_cursed:
		connection_cursed = false
		decrease_wealth_multiplier()
	else:
		connection_cursed = true
		increase_wealth_multiplier()


func _on_Health_Button_pressed() -> void:
	$PressSFX.play()
	yield($PressSFX, "play_complete")
	if health_cursed:
		health_cursed = false
		decrease_wealth_multiplier()
	else:
		health_cursed = true
		increase_wealth_multiplier()


func _on_Luck_Button_pressed() -> void:
	$PressSFX.play()
	yield($PressSFX, "play_complete")
	if luck_cursed:
		luck_cursed = false
		decrease_wealth_multiplier()
	else:
		luck_cursed = true
		increase_wealth_multiplier()


func _on_Time_Button_pressed() -> void:
	$PressSFX.play()
	yield($PressSFX, "play_complete")
	if time_cursed:
		time_cursed = false
		decrease_wealth_multiplier()
	else:
		time_cursed = true
		increase_wealth_multiplier()


func _on_Sign_Button_pressed() -> void:
	$PressSFX.play()
	yield($PressSFX, "play_complete")
	apply_curses()
	PlayerData.set_wealth_multiplier(calculated_wealth_multiplier)
	emit_signal("contract_signed")
	call_deferred("queue_free")


func _on_Sign_Button_mouse_entered() -> void:
	$HoverSFX.play()


func _on_Vision_Button_mouse_entered() -> void:
	$HoverSFX.play()


func _on_Connection_Button_mouse_entered() -> void:
	$HoverSFX.play()


func _on_Health_Button_mouse_entered() -> void:
	$HoverSFX.play()


func _on_Luck_Button_mouse_entered() -> void:
	$HoverSFX.play()


func _on_Time_Button_mouse_entered() -> void:
	$HoverSFX.play()
