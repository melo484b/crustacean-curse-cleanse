extends Label


const LABEL_TEXT: String = "Wealth: "
const ADD_TEXT: String = "+ "

var wealth: int = 0

onready var add_label: Label = $AddWealth
onready var increase_animation: AnimationPlayer = $AnimationPlayer


func _ready():
	animated_increase(10)


func increase_wealth(wealth_to_add: int) -> void:
	wealth += wealth_to_add


func update_label() -> void:
	text = LABEL_TEXT + str(wealth)


func animated_increase(new_wealth: int) -> void:
	add_label.text = ADD_TEXT + str(new_wealth)
	increase_animation.play("add_wealth")
	yield(increase_animation, "animation_finished")
	increase_wealth(new_wealth)
	update_label()
	
