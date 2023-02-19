extends Node


var rng: RandomNumberGenerator = RandomNumberGenerator.new()

onready var enemy: PackedScene = preload("res://unit/EnemyUnit.tscn")
onready var spawn_layer: YSort = get_parent().get_node("SpawnLayer")
onready var wave_timer: Timer = $WaveTimer


func _ready() -> void:
	wave_timer.start()


func spawn_wave() -> void:
	for child in spawn_layer.get_children():
		var x_pos: float = rng.randf_range(-10.0, 10.0)
		if child.is_in_group("FOUNTAIN"):
			spawn_enemy(child.position + Vector2(x_pos, 0))
	wave_timer.wait_time = rng.randi_range(2, 9)


func spawn_enemy(spawn_position: Vector2) -> void:
	var enemy_instance: EnemyUnit = enemy.instance()
	enemy_instance.position = spawn_position
	spawn_layer.add_child(enemy_instance)


func _on_WaveTimer_timeout() -> void:
	spawn_wave()
