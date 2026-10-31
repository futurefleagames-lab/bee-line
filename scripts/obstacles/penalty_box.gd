extends Area2D


@export var penalties: Array[float] = [0.5, 1.0, 1.5]
@export var inactive: Texture2D
@export var active: Texture2D

@onready var sprite: Sprite2D = $Sprite2D

var activated: bool = false

func _ready() -> void:
	sprite.texture = inactive
	

func _on_body_entered(body: Node2D) -> void:
	if body.name != "Bee":
		return
	var level = get_tree().current_scene
	
	if level.level_finished or level.timer_paused:
		return
	
	sprite.texture = active
	
	var penalty: float = penalties.pick_random()
	level.add_penalty(penalty)
	


func _on_body_exited(body: Node2D) -> void:
	if body.name != "Bee":
		return
	sprite.texture = inactive
