extends CanvasLayer


onready var player_wealth_label: Label = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/PlayerWealth
onready var needed_wealth_label: Label = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/NeededWealth
onready var severed_label: Label = $SoulSeveredLabel
onready var reclaimed_label: Label = $SoulReclaimedLabel

func _ready() -> void:
	$AnimationPlayer.play("game_over_screen")


func show_player_wealth() -> void:
	player_wealth_label.text += str(PlayerData.get_wealth())


func show_needed_wealth() -> void:
	needed_wealth_label.text += str(PlayerData.get_soul_cost())


func show_result() -> void:
	if PlayerData.get_wealth() >= PlayerData.get_soul_cost():
		reclaimed_label.visible = true
	else:
		severed_label.visible = true


func _on_TryAgainButton_pressed() -> void:
	PlayerData.reset_player_data()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://level/Level.tscn")
