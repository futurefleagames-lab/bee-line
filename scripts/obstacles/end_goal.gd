extends Area2D

@export var medal_ui: CanvasLayer
@export var level: Node2D


var triggered = false

func _on_body_entered(body):
	if triggered:
		return

	if body.name == "Bee":
		triggered = true
		level.finish_level()
