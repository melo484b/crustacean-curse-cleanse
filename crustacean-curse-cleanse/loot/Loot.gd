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
	apply_loot_modifier()


func apply_loot_modifier() -> void:
	var loot_modifier = rng.randf_range(1.0, 2.0) * PlayerData.get_luck()
	loot_value = int(loot_value * loot_modifier)


func _on_PickupDetection_body_entered(body) -> void:
	if body.is_in_group("PLAYER"):
		emit_signal("picked_up", loot_value)
		# TODO: Replace with sick animation
		queue_free()
