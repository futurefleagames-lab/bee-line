extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Bee":
		body.velocity = body.velocity.bounce(Vector2(1,0).rotated(rotation + PI/2)) *1.1
		body.state = "stunned"
		body.stun_timer = 0.2
