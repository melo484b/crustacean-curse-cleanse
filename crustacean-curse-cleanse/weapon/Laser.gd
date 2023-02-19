extends Weapon


var beam_1_fired: bool = false
var beam_2_fired: bool = true
var current_beam: int = 1
var can_attack: bool = true

onready var beam_1: Line2D = $Beam_1
onready var beam_2: Line2D = $Beam_2
onready var attack_timer: Timer = $AttackCooldown


func _unhandled_input(_event) -> void:
	if Input.is_action_just_pressed("attack"):
		attack()


func _init() -> void:
	damage = 5.5
	knockback = 100


func attack() -> void:
	if can_attack:
		$LaserSFXmanager.play()
		can_attack = false
		match current_beam:
			1:
				beam_1.fire()
				current_beam += 1
			2:
				beam_2.fire()
				current_beam -= 1
		attack_timer.start()


func _on_HitArea_area_entered(area) -> void:
	if not area.is_in_group("PLAYER"):
		$LaserHitSFXmanager.play()
		area.get_parent().get_hurt(damage)
		area.get_parent().apply_knockback(get_global_position(), knockback)


func _on_AttackCooldown_timeout() -> void:
	can_attack = true
