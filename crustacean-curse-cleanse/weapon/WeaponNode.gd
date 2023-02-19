class_name WeaponNode
extends Node2D


export var attached_to_enemy: bool = false

onready	var claw: PackedScene = preload("res://weapon/Claw.tscn")
onready	var laser: PackedScene = preload("res://weapon/Laser.tscn")
onready	var cannon: PackedScene = preload("res://weapon/Cannon.tscn")


func _ready():
	if attached_to_enemy:
		deactivate()
		get_child(0).init_enemy_weapon()


func equip_player_weapon() -> void:
	match PlayerData.get_boon_selection():
		0:
			var claw_instance: Weapon = claw.instance()
			claw_instance.scale = Vector2(3, 3)
			add_child(claw_instance)
		1:
			add_child(laser.instance())
		2:
			add_child(cannon.instance())


func activate() -> void:
	if get_child(0).has_method("activate"):
		get_child(0).activate()
	

func deactivate() -> void:
	if get_child(0).has_method("deactivate"):
		get_child(0).deactivate()
