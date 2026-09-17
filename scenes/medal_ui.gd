extends CanvasLayer


@onready var medal_animation: AnimationPlayer = $MedalAnimation

func show_medal():
	print("showing medal")
	medal_animation.play("medal_appear")
	


func _input(event):
	if event.is_action_pressed("ui_accept"):
		print("space pressed")
		show_medal()
