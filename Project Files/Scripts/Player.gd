extends KinematicBody2D

const ACCELERATION = 90
const MAX_SPEED = 80
const WEIGHT = 100
const FRICTION = 0.1
const BOUNC = 0.5

var gravity = 100
var jet_pack_force = 150

var input_vector = Vector2.ZERO
var velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer

var stats = PlayerStats
var old_velocity_y = NAN

func _process(delta):
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if Input.is_action_pressed("jump"):
		input_vector.y = -1
	else:
		input_vector.y = 0
	
	if input_vector != Vector2.ZERO:
		if input_vector.x > 0 && input_vector.y == 0:
			animationPlayer.play("RunRight")
		elif input_vector.x < 0 && input_vector.y == 0:
			animationPlayer.play("RunLeft")
		elif input_vector.y == -1:
			if input_vector.x > 0:			
				animationPlayer.play("RightFly")	
			elif input_vector.x < 0:
				animationPlayer.play("LeftFly")			
			else:
				if "Right" in animationPlayer.current_animation:
					animationPlayer.play("RightFly")	
				else:
					animationPlayer.play("LeftFly")		
	else:
		if "Right" in animationPlayer.current_animation:
			animationPlayer.play("IdleRight")
		else:
			animationPlayer.play("IdleLeft")
	

func _physics_process(delta):
	velocity.y += input_vector.y * jet_pack_force * delta
	velocity.y += gravity * delta
	
	if self.is_on_floor():
		velocity.x = lerp(velocity.x, velocity.x + (input_vector.x * ACCELERATION), FRICTION)
		velocity.x = lerp(velocity.x, 0.0, FRICTION)
	
	var bounc = velocity.x
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if velocity.x == 0:
		velocity.x = -lerp(bounc, 0.0, BOUNC)
	
	
	if old_velocity_y != NAN && \
		(old_velocity_y - velocity.y) > 100:
		print("damage")
		print(old_velocity_y - velocity.y)
		var damag = (old_velocity_y - velocity.y) - 100
		stats.take_damage(clamp(damag/100, 0, 1))
	
	old_velocity_y = velocity.y
	
