#Script by Enoch
extends CharacterBody2D


const FORCE = 175.0
const AIR_FRICTION = 0.12

func _physics_process(delta: float) -> void:
	#Get the desired direction based on input
	var wish_direction = Input.get_vector("left","right","up","down")
	velocity = velocity + wish_direction * FORCE - velocity * AIR_FRICTION
	move_and_slide()
