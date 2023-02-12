class_name Unit
extends KinematicBody2D


signal take_damage


const NORMALIZED_MOVEMENT: float = 1.0
const MOVEMENT_CONTROLS: Array = ["up", "down", "left", "right"]

export var speed: float = 200.0
export var friction: float = 0.1
var _velocity: Vector2 = Vector2()
var moving: bool = false

export var health: int = 10

onready var animation: AnimatedSprite = $AnimatedSprite
onready var weapon_node: WeaponNode = $WeaponNode


func _ready() -> void:
	_on_ready()


func _physics_process(_delta) -> void:
	move()
	animate_movement()


func _on_ready() -> void:
# warning-ignore:narrowing_conversion
	health *= PlayerData.get_health_modifier()
	friction *= PlayerData.get_connection()


func move() -> void:
	var direction: Vector2 = get_input_direction()
	if direction.length() > NORMALIZED_MOVEMENT:
		direction = direction.normalized()
	if direction != Vector2.ZERO:
		moving = true
	else:
		moving = false
	var target_velocity: Vector2 = direction * speed
	_velocity += (target_velocity - _velocity) * friction
	_velocity = move_and_slide(_velocity)


func get_input_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"), 
		Input.get_action_strength("down") - Input.get_action_strength("up")
		)


func animate_movement() -> void:
	if moving:
		animation.play("walk")
	else:
		animation.play("idle")


func attack() -> void:
	# TODO: Attack logic
	# TODO: Attack sfx
	pass

func get_hurt() -> void:
	# TODO: Hurt logic
	# TODO: Hurt sfx
	emit_signal("take_damage")
	animation.play("hurt")
