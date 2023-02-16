extends Node2D


signal picked_up(loot_value)


const LOOT_SACK_VALUE: int = 1000
const CHALICE_VALUE: int = 5000

var loot_value: int = -1
var animation_index: int 
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

onready var animated_sprite: AnimatedSprite = $AnimatedSprite


func _ready() -> void:
	generate_loot()
	

func _on_PickupDetection_area_entered(area) -> void:
	if area.is_in_group("PLAYER"):
		emit_signal("picked_up", loot_value)


func generate_loot() -> void:
	rng.randomize()
	animation_index = rng.randi_range(0, 1)
	match animation_index:
		0:
			animated_sprite.animation = "loot_sack_sparkle"
			loot_value = LOOT_SACK_VALUE
		1:
			animated_sprite.animation = "chalice_sparkle"
			loot_value = CHALICE_VALUE
