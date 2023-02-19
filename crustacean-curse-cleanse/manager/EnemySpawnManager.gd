extends Node


var rng: RandomNumberGenerator = RandomNumberGenerator.new()

onready var enemy: PackedScene = preload("res://unit/EnemyUnit.tscn")
onready var spawn_layer: YSort = get_parent().get_node("SpawnLayer")


func _ready() -> void:
	spawn_enemy(Vector2(100, 100))
	spawn_enemy(Vector2(200, 100))
	spawn_enemy(Vector2(150, 100))
	spawn_enemy(Vector2(100, 150))


func spawn_enemy(spawn_position: Vector2) -> void:
	var enemy_instance: EnemyUnit = enemy.instance()
	enemy_instance.position = spawn_position
	spawn_layer.add_child(enemy_instance)
