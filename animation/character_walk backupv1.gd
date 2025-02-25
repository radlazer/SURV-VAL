extends CharacterBody2D

signal health_depleted

var health = 100.0
@onready var animated_sprite = $AnimatedSprite2D
@onready var health_bar_sprite = %ProgressBarTexture
@onready var hurt_box = $HurtBox  

var speed = 600.0
var last_direction = Vector2.DOWN

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	self.velocity = direction * speed
	move_and_slide()

	if self.velocity.length() > 0:
		update_animation(self.velocity)
		last_direction = self.velocity.normalized()
	else:
		play_idle_animation()
		
	const DAMAGE_RATE = 300.0
	var overlapping_mobs = hurt_box.get_overlapping_bodies()  
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		update_health(health)
		if health <= 0.0:
			health_depleted.emit()
	
func update_health(value):
	var max_hp = 100.0
	var frame_count = health_bar_sprite.sprite_frames.get_frame_count("default")
	
	var new_frame = int((1.0 - (value / max_hp)) *(frame_count - 1) )
	health_bar_sprite.frame = clamp(new_frame, 0, frame_count - 1)


func update_animation(velocity: Vector2):
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

	elif last_direction.x > 0.5:
		animated_sprite.play("idle_right_down")

	elif last_direction.x < -0.5:
		animated_sprite.play("idle_left_down")

	else:
		animated_sprite.play("idle_down")
