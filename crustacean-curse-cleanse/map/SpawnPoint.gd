extends Position2D


export var ready: bool = true
export var x_boundary: Vector2 = Vector2(43.0, 981.0)
export var y_boundary: Vector2 = Vector2(43.0, 557.0)

var target_location: Vector2 = Vector2()
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

onready var timer: Timer = $ReadyTimer


func _ready():
	rng.randomize()


func shuffle_position() -> void:
	var new_x: float = rng.randf_range(x_boundary[0], x_boundary[1])
	var new_y: float = rng.randf_range(y_boundary[0], y_boundary[1])
	position = Vector2(new_x, new_y)


func set_timer_length() -> void:
	timer.wait_time = rng.randi_range(3, 9)


func start_spawn_timer() -> void:
	ready = false
	timer.start()


func is_ready() -> bool:
	return ready


func _on_ReadyTimer_timeout() -> void:
	ready = true
	set_timer_length()
