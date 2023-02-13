extends Weapon


var cannonball: PackedScene = preload("res://weapon/Cannonball.tscn")
var target: Vector2 = Vector2()
var fired: bool = false

func _init():
	damage = 3.2
	knockback = 10


func _unhandled_input(_event) -> void:
	if Input.is_action_just_pressed("attack"):
		attack()


func attack() -> void:
	if not fired:
		fired = true
		var ball_instance = cannonball.instance()
		get_tree().get_root().add_child(ball_instance)
		ball_instance.position = get_parent().get_parent().position
		ball_instance.set_damage(damage)
		ball_instance.set_knockback(knockback)
		ball_instance.set_target(get_global_mouse_position())
		yield(get_tree().create_timer(0.25), "timeout")
		fired = false
