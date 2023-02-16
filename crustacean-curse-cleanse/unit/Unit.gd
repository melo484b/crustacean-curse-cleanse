class_name Unit
extends KinematicBody2D


signal take_damage(damage)


enum STATE { MOVING, IDLE, HURTING }

const NORMALIZED_MOVEMENT: float = 1.0
const MOVEMENT_CONTROLS: Array = ["up", "down", "left", "right"]

export var speed: float = 200.0
export var friction: float = 0.1
var knockback_vector: Vector2 = Vector2()
var velocity: Vector2 = Vector2()
var moving: bool = false
var current_state: int = STATE.IDLE

export var health: float = 10

onready var animation: AnimatedSprite = $AnimatedSprite


func _ready() -> void:
	_on_ready()


func _physics_process(_delta) -> void:
	move()
	animate_movement()
	var _knockback = move_and_slide(knockback_vector)
	knockback_vector = lerp(knockback_vector, Vector2.ZERO, 0.2)


func _on_ready() -> void:
	pass


func move() -> void:
	pass


func get_input_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"), 
		Input.get_action_strength("down") - Input.get_action_strength("up")
		)


func animate_movement() -> void:
	match current_state:
		STATE.MOVING:
			animation.play("walk")
		STATE.IDLE:
			animation.play("idle")
		STATE.HURTING:
			animation.play("hurt")


func attack() -> void:
	pass


func get_hurt(damage: float) -> void:
	current_state = STATE.HURTING
	# TODO: Hurt sfx
	emit_signal("take_damage", damage)


func apply_knockback(knockback_location: Vector2, knockback_strength: int) -> void:
	knockback_vector = (global_position - knockback_location) * knockback_strength


func die() -> void:
	queue_free()
