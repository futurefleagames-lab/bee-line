extends Node2D


@export var bee_scene: PackedScene
@export var min_speed: float = 100.0
@export var max_speed: float = 700.0
@export var min_scale: float = 0.2
@export var max_scale: float = 3.0
@export var min_fps: float = 2.0
@export var max_fps: float = 14.0
@export var degrees: float = 0.0
@export var spawn_margin: float = 150.0
@export var max_bees: int = 12

@onready var timer: Timer = $spawn

var rng := RandomNumberGenerator.new()
var active_bees: Array[Node2D] = []


func _ready() -> void:
	rng.randomize()
	timer.timeout.connect(spawn_bee)

func spawn_bee() -> void:
	#if you remove the scene via inspector in main menu, you'll have to
	#add some condition here to fix whatever problem ensues

	if active_bees.size() >= max_bees:
		return

	var screen_size := get_viewport_rect().size
	var direction := Vector2.RIGHT.rotated(deg_to_rad(degrees))
	var speed := rng.randf_range(min_speed, max_speed)
	var bee_size := rng.randf_range(min_scale, max_scale)
	var fps := rng.randf_range(min_fps, max_fps)
	var facing := rng.randf_range(0.0, TAU)
	var start := get_spawn_position(screen_size, direction)
	var bee = bee_scene.instantiate()
	add_child(bee)

	bee.global_position = start
	bee.setup(direction, speed, bee_size, fps, facing)
	active_bees.append(bee)

	var travel_distance := screen_size.length() + spawn_margin * 4.0
	var lifetime := travel_distance / speed

	get_tree().create_timer(lifetime).timeout.connect(
		func():
			active_bees.erase(bee)
			if is_instance_valid(bee):
				bee.queue_free())

func get_spawn_position(screen_size: Vector2, direction: Vector2) -> Vector2:
	var margin := spawn_margin

	if absf(direction.x) >= absf(direction.y):
		var x := -margin if direction.x > 0.0 else screen_size.x + margin
		var y := rng.randf_range(-margin, screen_size.y + margin)
		return to_global(Vector2(x, y))
	else:
		var x := rng.randf_range(-margin, screen_size.x + margin)
		var y := -margin if direction.y > 0.0 else screen_size.y + margin
		return to_global(Vector2(x, y))
