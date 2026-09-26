#Script by Enoch
extends CharacterBody2D


const FORCE = 175.0
const AIR_FRICTION = 0.12
var state = "flying"
var wall_timer = 0.3
var dash_timer = 0.25
var stored_speed = 0.0
var wall_normal = Vector2()
var wish_vector = Vector2()
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	#Get the desired direction based on input
	if state != "dashing":
		wish_vector = Input.get_vector("left","right","up","down")
	if state == "flying":
		if Input.is_action_just_pressed("dash"):
			dash_timer = 0.25
			state = "dashing"
		else:
			velocity = velocity + wish_vector * FORCE - velocity * AIR_FRICTION
			stored_speed = velocity.length()
	elif state == "dashing":
		if dash_timer <= 0:
			state = "flying" 
		elif dash_timer < 0.002:
			velocity = Vector2(1,0).rotated(wish_vector.angle()) * 1000
		elif dash_timer > 0.248:
			velocity = Vector2(1,0).rotated(wish_vector.angle()) * 500
		else:
			velocity = Vector2(1,0).rotated(wish_vector.angle()) * 3500
		dash_timer = dash_timer - delta
	elif state == "wall":
		if Input.is_action_just_pressed("dash"):
			velocity = Vector2(1,0).rotated(wish_vector.angle()) * stored_speed * (wall_timer/0.05)
			state = "flying"
		elif wall_timer <= 0:
			velocity = wall_normal * 500
			state = "flying"
		else:
			wall_timer = wall_timer - 1 * delta
	#wall_min_slide_angle = 0
	#move_and_slide()
	if wish_vector.x > 0:
		$AnimatedSprite2D.set_flip_h(1)
	elif wish_vector.x < 0:
		$AnimatedSprite2D.set_flip_h(0)
	var collision = move_and_collide(velocity * delta)
	if collision:
		if  state != "wall":
			state = "wall"
			wall_timer = 0.3
		wall_normal = collision.get_normal()
