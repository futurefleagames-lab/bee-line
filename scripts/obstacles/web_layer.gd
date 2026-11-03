extends Area2D

@export var trap_duration: float = 1.5

func _on_body_entered(body: Node2D) -> void:
	if body.name == "bee" or "Bee" and body is CharacterBody2D:
	
		body.velocity = Vector2.ZERO
	
		body.set_physics_process(false)
	
		await get_tree().create_timer(trap_duration).timeout
	
		if is_instance_valid(body):
			body.set_physics_process(true)
		
