#Script by Enoch
extends CharacterBody2D


const SPEED = 300.0

func _physics_process(delta: float) -> void:
	#Get the desired direction based on input
	var wish_direction = Input.get_vector("left","right","up","down")
	
	move_and_slide()
