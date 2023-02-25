extends Weapon


var cannonball: PackedScene = preload("res://weapon/Cannonball.tscn")
var target: Vector2 = Vector2()

func _init() -> void:
	damage = 4.5
	knockback = 1200


func attack() -> void:
	$CannonSFXmanager.play()
	var ball_instance = cannonball.instance()
	get_tree().get_root().add_child(ball_instance)
	ball_instance.position = get_parent().get_parent().position
	ball_instance.set_damage(damage)
	ball_instance.set_knockback(knockback)
	ball_instance.set_target(get_global_mouse_position())
	$FireTimer.start()


func _on_FireTimer_timeout() -> void:
	attack()
