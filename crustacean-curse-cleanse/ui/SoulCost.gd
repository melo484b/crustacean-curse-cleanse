extends CanvasLayer


var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var soul_cost: int = 0

onready var cost_label: Label = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/CostLabel

func _init():
	rng.randomize()
	soul_cost = rng.randi_range(10000, 1000000)


func _ready() -> void:
	cost_label.text = str(soul_cost)
	PlayerData.set_soul_cost(soul_cost)
