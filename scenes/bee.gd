#Script by Enoch
extends CharacterBody2D


const FORCE = 175.0
const AIR_FRICTION = 0.12
var state = "flying"
var wall_timer = 0.3
var stored_speed = 0.0
var wall_normal = Vector2()
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	#Get the desired direction based on input
	var wish_direction = Input.get_vector("left","right","up","down")
	if state == "flying":
		velocity = velocity + wish_direction * FORCE - velocity * AIR_FRICTION
		stored_speed = velocity.length()
	elif state == "wall":
		if Input.is_action_just_pressed("dash"):
			velocity = wish_direction * stored_speed * (wall_timer/0.1)
			state = "flying"
		elif wall_timer <= 0:
			velocity = wall_normal * 500
			state = "flying"
		else:
			wall_timer = wall_timer - 1 * delta
	#wall_min_slide_angle = 0
	#move_and_slide()
	var collision = move_and_collide(velocity * delta)
	if collision:
		if  state != "wall":
			state = "wall"
			wall_timer = 0.3
		wall_normal = collision.get_normal()
