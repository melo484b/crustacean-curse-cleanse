extends Node


const MAX_ENEMIES: int = 8
const MIN_COORD: float = -10.0
const MAX_COORD: float = 10.0

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var active_enemies: int = 0

onready var enemy: PackedScene = preload("res://unit/EnemyUnit.tscn")
onready var spawn_layer: YSort = get_parent().get_node("SpawnLayer")
onready var wave_timer: Timer = $WaveTimer


func _ready() -> void:
	rng.randomize()


func spawn_wave() -> void:
		for child in spawn_layer.get_children():
			var x_pos: float = rng.randf_range(MIN_COORD, MAX_COORD)
			var y_pos: float = rng.randf_range(MIN_COORD, MAX_COORD)
			if child.is_in_group("FOUNTAIN"):
				if active_enemies < MAX_ENEMIES:
					spawn_enemy(child.position + Vector2(x_pos, y_pos))
		wave_timer.wait_time = rng.randi_range(2, 9)
		wave_timer.start()


func spawn_enemy(spawn_position: Vector2) -> void:
	var enemy_instance: EnemyUnit = enemy.instance()
	enemy_instance.position = spawn_position
	spawn_layer.add_child(enemy_instance)
# warning-ignore:return_value_discarded
	enemy_instance.connect("enemy_died", self, "decrement_active_enemies")
	active_enemies += 1


func decrement_active_enemies(_position: Vector2) -> void:
	active_enemies -= 1


func _on_WaveTimer_timeout() -> void:
	spawn_wave()
