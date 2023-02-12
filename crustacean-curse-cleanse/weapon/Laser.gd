extends Weapon


var beam_1_fired: bool = false
var beam_2_fired: bool = false


onready var beam_1: Line2D = $Beam_1
#onready var beam_2: Line2D = $Beam_2


func _init():
	damage = 5.5
	knockback = 0


func attack() -> void:
	pass


func _on_HitArea_area_entered(area):
	if not area.is_in_group("PLAYER"):
		print("damaging enemy")
