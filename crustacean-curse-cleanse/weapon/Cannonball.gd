extends KinematicBody2D


const INCREASED_AREA_SCALE: Vector2 = Vector2(1.5, 1.5)

var speed: int = 30000
var target: Vector2 = Vector2()
var velocity: Vector2 = Vector2()
var fired: bool = false
var hit: bool = false
var target_reached: bool = false
var exploding: bool = false

onready var particles: Particles2D = $ExplosionParticles
onready var collider: Area2D = $HitDetectionArea
onready var timer: Timer = $CleanupTimer


func _physics_process(delta) -> void:
	move(delta)


func set_target(new_target: Vector2) -> void:
	if not fired:
		target = new_target
		fired = true


func move(delta: float) -> void:
	if not target_reached:
		velocity = position.direction_to(target) * speed * delta
		rotation_degrees += 1
	if position.distance_to(target) > 10:
		velocity = move_and_slide(velocity)
	else:
		if target != position:
			target_reached = true
			increase_detection_size()
			if not hit and not exploding:
				explode()


func increase_detection_size() -> void:
	collider.scale = INCREASED_AREA_SCALE


func explode() -> void:
	exploding = true
	particles.emitting = true
	print("Starting timer")
	timer.start()


func _on_CleanupTimer_timeout() -> void:
	print("Timer end")
	visible = false
	queue_free()


func _on_HitDetectionArea_area_entered(area) -> void:
	if !area.is_in_group("PLAYER"):
		hit = true
		target = position
		explode()
