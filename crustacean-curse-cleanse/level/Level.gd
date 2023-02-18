extends Node2D


# Units
onready var player_unit: PackedScene = preload("res://unit/PlayerUnit.tscn")
onready var enemy_unit: PackedScene = preload("res://unit/EnemyUnit.tscn")
# UI objects
onready var start_menu: PackedScene = preload("res://ui/StartMenu.tscn")
onready var boon_select: PackedScene = preload("res://ui/BoonSelect.tscn")
onready var contract_menu: PackedScene = preload("res://ui/ContractMenu.tscn")
onready var game_over: PackedScene = preload("res://ui/GameOver.tscn")
# Sound
onready var music: AudioStreamPlayer = $Music
onready var environment: AudioStreamPlayer = $Environment

onready var spawn_layer: YSort = $SpawnLayer
onready var player_ui: CanvasLayer = $PlayerUI


func _ready() -> void:
	show_start_menu()


func show_start_menu() -> void:
	var start_menu_instance: CanvasLayer = start_menu.instance()
	add_child(start_menu_instance)
# warning-ignore:return_value_discarded
	start_menu_instance.connect("start_the_game", self, "show_boon_select")


func show_boon_select() -> void:
	var boon_select_instance = boon_select.instance()
	add_child(boon_select_instance)
# warning-ignore:return_value_discarded
	boon_select_instance.connect("boon_confirmed", self, "show_contract")


func show_contract() -> void:
	environment.play()
	var contract_menu_instance = contract_menu.instance()
	add_child(contract_menu_instance)
# warning-ignore:return_value_discarded
	contract_menu_instance.connect("contract_signed", self, "spawn_player")


func start_timer() -> void:
	player_ui.start_ui_timer()


func spawn_player() -> void:
	var player = player_unit.instance()
	player.position = Vector2(512, 300)
	player.connect("take_damage", player_ui, "reduce_health_bar")
	spawn_layer.add_child(player)
	start_timer()
	music.play()


func show_game_over() -> void:
	var game_over_instance = game_over.instance()
	add_child(game_over_instance)


func _on_PlayerUI_game_time_up() -> void:
	show_game_over()


func _on_PlayerUI_player_death() -> void:
	show_game_over()
