extends Area2D

@export var trap_duration: float = 1.5


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if not (body is CharacterBody2D and body.name == "Bee"):
		return

	var bee := body as CharacterBody2D

	if not bee.is_physics_processing():
		return

	# Stop the bee
	bee.velocity = Vector2.ZERO
	bee.set_physics_process(false)

	# Wait 1.5 seconds
	await get_tree().create_timer(trap_duration).timeout

	# Release the bee
	if is_instance_valid(bee):
		bee.set_physics_process(true)
