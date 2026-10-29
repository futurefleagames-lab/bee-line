extends Area2D

@export var medal_ui: CanvasLayer

var triggered = false

func _on_body_entered(body):
	if triggered:
		return

	if body.name == "Bee":
		triggered = true
		medal_ui.show_medal()
