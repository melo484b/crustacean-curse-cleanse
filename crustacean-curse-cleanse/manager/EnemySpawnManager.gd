extends Node


var rng: RandomNumberGenerator = RandomNumberGenerator.new()

onready var enemy: PackedScene = preload("res://unit/EnemyUnit.tscn")
onready var spawn_layer: YSort = get_parent().get_node("SpawnLayer")
onready var wave_timer: Timer = $WaveTimer
onready var spawn_points: Node = $SpawnPoints


func _ready() -> void:
	wave_timer.start()


func spawn_wave() -> void:
	for point in spawn_points.get_children():
		if point.is_ready():
			spawn_enemy(point.position)
			point.start_spawn_timer()


func randomize_spawn_points() -> void:
	for point in spawn_points.get_children():
		point.shuffle_position()


func spawn_enemy(spawn_position: Vector2) -> void:
	var enemy_instance: EnemyUnit = enemy.instance()
	enemy_instance.position = spawn_position
	spawn_layer.add_child(enemy_instance)


func _on_WaveTimer_timeout() -> void:
	spawn_wave()
	randomize_spawn_points()
