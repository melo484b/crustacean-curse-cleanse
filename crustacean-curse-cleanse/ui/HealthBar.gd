extends CenterContainer


signal empty


var dead: bool = false

onready var bar: TextureProgress = $MarginContainer/PanelContainer/MarginContainer/TextureProgress
onready var tween: Tween = $Tween


func set_value(new_value: int) -> void:
	bar.value = new_value


func take_damage(damage_amount: int) -> void:
	if not dead:
		if bar.value <= 0 or bar.value - damage_amount * 10 <= 0:
			emit_signal("empty")
			dead = true
	# warning-ignore:return_value_discarded
		tween.interpolate_property(bar, "value",
			bar.value, bar.value - damage_amount * 10, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	# warning-ignore:return_value_discarded
		tween.start()
