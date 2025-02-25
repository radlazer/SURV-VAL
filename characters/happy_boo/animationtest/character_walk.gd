extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
var speed = 200.0
var last_direction = Vector2.ZERO  

func _physics_process(delta):
	var velocity = Vector2.ZERO  

	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	elif Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	elif Input.is_action_pressed("move_right"):
		velocity.x += 1

	velocity = velocity.normalized() * speed

	if velocity.length() > 0:
		last_direction = velocity.normalized()

	self.velocity = velocity

	move_and_slide()

	update_animation(velocity)

func update_animation(velocity: Vector2):
	if velocity.length() == 0:
		play_idle_animation()
	else:
		play_walk_animation(velocity)

func play_walk_animation(velocity: Vector2):
	if velocity.y > 0.5:
		if velocity.x > 0.5:
			animated_sprite.play("walk_right_down")
		elif velocity.x < -0.5:
			animated_sprite.play("walk_left_down")
		else:
			animated_sprite.play("walk_down")
	
	elif velocity.y < -0.5:
		if velocity.x > 0.5:
			animated_sprite.play("walk_right_up")
		elif velocity.x < -0.5:
			animated_sprite.play("walk_left_up")
		else:
			animated_sprite.play("walk_up")
	
	elif velocity.x > 0.5 and abs(velocity.y) < 0.5:
		animated_sprite.play("walk_right_down")
	
	elif velocity.x < -0.5 and abs(velocity.y) < 0.5:
		animated_sprite.play("walk_left_down")
		
func play_idle_animation():
	if last_direction.y > 0.5:
		if last_direction.x > 0.5:
			animated_sprite.play("idle_right_down")
		elif last_direction.x < -0.5:
			animated_sprite.play("idle_left_down")
		else:
			animated_sprite.play("idle_down")
	
	elif last_direction.y < -0.5:
		if last_direction.x > 0.5:
			animated_sprite.play("idle_right_up")
		elif last_direction.x < -0.5:
			animated_sprite.play("idle_left_up")
		else:
			animated_sprite.play("idle_up")
	
	elif last_direction.x > 0.5 and abs(last_direction.y) < 0.5:
		animated_sprite.play("idle_right_down")
	
	elif last_direction.x < -0.5 and abs(last_direction.y) < 0.5:
		animated_sprite.play("idle_left_down")
