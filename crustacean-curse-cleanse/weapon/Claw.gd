extends Weapon


const EVIL_MODULATION: String = "#820000"

var active: bool = true
var enemy: bool = false

onready var collider: CollisionShape2D = $Area2D/CollisionShape2D
onready var collision_area: Area2D = $Area2D
onready var animation: AnimatedSprite = $ClawAttackAnimationSprite


func _init() -> void:
	damage = 3.0
	knockback = 500


func _unhandled_input(_event):
	if !enemy:
		look_at(get_global_mouse_position())
		rotation_degrees += 180
		


func init_enemy_weapon() -> void:
	enemy = true
	active = false
	collision_area.set_collision_mask_bit(2, false)
	collision_area.set_collision_mask_bit(1, true)
	modulate = EVIL_MODULATION
	


func attack() -> void:
	if enemy:
		update_direction()
	animation.frame = 0
	animation.playing = true
	$ClawSFXmanager.play()


func activate() -> void:
	active = true


func deactivate() -> void:
	active = false


func _on_ClawAttackAnimationSprite_attack_frame() -> void:
	collider.disabled = false


func _on_ClawAttackAnimationSprite_animation_finished() -> void:
	collider.disabled = true


func _on_Timer_timeout() -> void:
	if active:
		attack()


func _on_Area2D_area_entered(area) -> void:
	area.get_parent().get_hurt(damage)
	area.get_parent().apply_knockback(get_global_position(), knockback)
