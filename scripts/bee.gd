#Script by Enoch
extends CharacterBody2D


const FORCE = 175.0
const AIR_FRICTION = 0.12
const DASH_SPEED = 3500
var state = "flying"
var wall_timer = 0.3
var dash_timer = 0.25
var stored_velocity = Vector2()
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
			stored_velocity = velocity
			
	
	elif state == "dashing":
		if dash_timer <= 0:
			state = "flying" 
		elif dash_timer < 0.002:
			velocity = Vector2(1,0).rotated(wish_vector.angle()) * 2 * DASH_SPEED / 7
		elif dash_timer > 0.248:
			velocity = Vector2(1,0).rotated(wish_vector.angle()) * DASH_SPEED / 7
		else:
			velocity = Vector2(1,0).rotated(wish_vector.angle()) * DASH_SPEED
		dash_timer = dash_timer - delta
	elif state == "wall":
		if Input.is_action_just_pressed("dash"):
			velocity = Vector2(1,0).rotated(wish_vector.angle()) * stored_velocity.length() * (wall_timer/0.05)
			state = "flying"
			$AnimatedSprite2D.rotation = 0
			$AnimatedSprite2D.play("flight")
			$AnimatedSprite2D.offset = Vector2()
		elif wall_timer <= 0:
			velocity = wall_normal * 500
			state = "flying"
			$AnimatedSprite2D.rotation = 0
			$AnimatedSprite2D.play("flight")
			$AnimatedSprite2D.offset = Vector2()
		else:
			wall_timer = wall_timer - 1 * delta
	#wall_min_slide_angle = 0
	#move_and_slide()
	if state != "wall":
		if wish_vector.x > 0:
			$AnimatedSprite2D.set_flip_h(1)
		elif wish_vector.x < 0:
			$AnimatedSprite2D.set_flip_h(0)
	var collision = move_and_collide(velocity * delta)
	if collision:
		wall_normal = collision.get_normal()
		if  state != "wall":
			$AnimatedSprite2D.play("cling")
			$AnimatedSprite2D.rotation = (wall_normal.angle() + PI/2)
			$AnimatedSprite2D.offset = Vector2(0,2)
			if stored_velocity.x > 0 && wall_normal.y > 0:
				$AnimatedSprite2D.set_flip_h(0)
			elif stored_velocity.x < 0 && wall_normal.y > 0:
				$AnimatedSprite2D.set_flip_h(1)
			state = "wall"
			wall_timer = 0.3
