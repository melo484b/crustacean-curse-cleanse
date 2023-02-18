class_name EnemyUnit
extends Unit


signal enemy_died(enemy_position)


const EVIL_MODULATION: String = "#820000"

var health_bar: CenterContainer
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

onready var loot: PackedScene = preload("res://loot/Loot.tscn")
onready var player_ui: CanvasLayer = get_parent().get_parent().find_node("PlayerUI")


func _physics_process(_delta) -> void:
	move()


func _on_ready() -> void:
	health_bar = $HealthBar
	animation.modulate = EVIL_MODULATION


func move() -> void:
	# TODO
	pass


func get_player() -> KinematicBody2D:
	var player: KinematicBody2D = get_tree().find_node("PlayerUnit")
	print(player.name)
	return player


func attack() -> void:
	# TODO: Attack logic
	pass


func get_hurt(damage: float) -> void:
	# TODO: Hurt sfx
	current_state = STATE.HURTING
	health_bar.take_damage(damage)


func spawn_loot() -> void:
	var loot_instance: Node2D = loot.instance()
	get_parent().add_child(loot_instance)
	loot_instance.position = position
# warning-ignore:return_value_discarded
	loot_instance.connect("picked_up", player_ui, "pick_up_loot")


func die() -> void:
	emit_signal("enemy_died", position)
	spawn_loot()
	call_deferred("queue_free")


func _on_HealthBar_empty() -> void:
	call_deferred("die")
