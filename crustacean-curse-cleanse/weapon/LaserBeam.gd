extends Line2D


var can_fire: bool = true
var target: Vector2 = Vector2()

onready var particles: Particles2D = $LaserParticles
onready var hit_area: Area2D = $HitArea
onready var effect_timer: Timer = $DamageEffectTimer


func _ready() -> void:
	pass


func fire() -> void:
	if can_fire:
		can_fire = false
		target = get_local_mouse_position()
		add_point(target)
		particles.position = target
		hit_area.position = target
		hit_area.monitoring = true
		particles.visible = true
		effect_timer.start()
		yield(effect_timer, "timeout")
		remove_point(1)


func _on_HitArea_area_entered(_area) -> void:
	hit_area.set_deferred("monitoring", false)


func _on_DamageEffectTimer_timeout() -> void:
	hit_area.monitoring = false
	can_fire = true
	particles.visible = false
