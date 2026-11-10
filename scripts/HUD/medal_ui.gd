extends CanvasLayer

@onready var medal_animation: AnimationPlayer = $MedalAnimation
@onready var medal_sprite: AnimatedSprite2D = $Medal

func _ready() -> void:
	medal_sprite.hide()
	

func show_medal_at(canvas_position: Vector2, medal_type: String = "bronze") -> void:
	var tier := medal_type.to_lower()

	if not medal_sprite.sprite_frames.has_animation(tier):
		push_warning("Medal animation not found: " + tier)
		return

	medal_animation.stop()

	
	var texture: Texture2D = medal_sprite.sprite_frames.get_frame_texture(tier, 0)

	
	var image_size: float = float(max(texture.get_width(), texture.get_height()))
	var fit_scale: float = 32.0 / image_size

	
	scale = Vector2(fit_scale, fit_scale)

	
	medal_sprite.position = canvas_position / fit_scale

	# correct medal
	
	medal_sprite.play(tier)
	medal_sprite.show()

	# animation
	medal_animation.play("medal_appear")
	
	
	
func hide_medal() -> void:
	medal_animation.stop()
	medal_sprite.stop()
	medal_sprite.hide()
	
