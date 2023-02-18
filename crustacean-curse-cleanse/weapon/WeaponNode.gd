class_name WeaponNode
extends Node2D


onready	var claw: PackedScene = preload("res://weapon/Claw.tscn")
onready	var laser: PackedScene = preload("res://weapon/Laser.tscn")
onready	var cannon: PackedScene = preload("res://weapon/Cannon.tscn")


func equip_player_weapon() -> void:
	match PlayerData.get_boon_selection():
		0:
			add_child(claw.instance())
		1:
			add_child(laser.instance())
		2:
			add_child(cannon.instance())


func equip_enemy_weapon() -> void:
	var claw_weapon: Weapon = claw.instance()
	add_child(claw_weapon)
	claw_weapon.init_enemy_weapon()
	
