extends CanvasLayer

@onready var medal_animation: AnimationPlayer = $MedalAnimation
@onready var medal_sprite: AnimatedSprite2D = $Medal

func show_medal():
	medal_sprite.play("default")
	medal_animation.play("medal_appear")
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		show_medal()
