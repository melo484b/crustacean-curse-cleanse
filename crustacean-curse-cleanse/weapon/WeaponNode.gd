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
