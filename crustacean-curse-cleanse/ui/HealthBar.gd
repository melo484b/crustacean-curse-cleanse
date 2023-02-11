extends CenterContainer


onready var bar: TextureProgress = $MarginContainer/PanelContainer/MarginContainer/TextureProgress
onready var tween: Tween = $Tween


func _ready() -> void:
	take_damage(20)


func set_value(new_value: int) -> void:
	bar.value = new_value


func take_damage(damage_amount: int) -> void:
	tween.interpolate_property(bar, "value",
		bar.value, bar.value - damage_amount, 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
