extends Node2D


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var velocity: Vector2 = Vector2.RIGHT * 200.0

func setup(move: Vector2, speed: float, beescale: float, fps: float, facing: float) -> void:
	velocity = move.normalized() * speed
	scale = Vector2.ONE * beescale
	rotation = facing
	
	await ready
	sprite.play()
	
	var base_fps := sprite.sprite_frames.get_animation_speed(sprite.animation)
	sprite.speed_scale = fps / maxf(base_fps, 0.01)
	
func _process(delta: float) -> void:
	global_position += velocity * delta
