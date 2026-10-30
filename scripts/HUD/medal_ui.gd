extends CanvasLayer

@onready var medal_animation: AnimationPlayer = $MedalAnimation
@onready var medal_sprite: AnimatedSprite2D = $Medal

func _ready() -> void:
	medal_sprite.hide()
	

func show_medal_at(canvas_position: Vector2) -> void:
	medal_animation.stop()
	medal_sprite.position = canvas_position
	medal_sprite.set_frame_and_progress(0,0.0)
	medal_sprite.show()
	medal_sprite.play("default")
	medal_animation.play("medal_appear")
	
	
	
func hide_medal() -> void:
	medal_animation.stop()
	medal_sprite.stop()
	medal_sprite.hide()
	
