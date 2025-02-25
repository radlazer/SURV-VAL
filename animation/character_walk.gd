extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D  # Mengakses AnimatedSprite2D node
var speed = 200.0
var last_direction = Vector2.ZERO  # Menyimpan arah terakhir pergerakan

func _ready():
	if not animated_sprite:
		print("AnimatedSprite2D node not found!")  # Cek jika node tidak ditemukan

func _physics_process(delta):
	var velocity = Vector2.ZERO  # Kecepatan bergerak karakter
	
	# Mengecek input pergerakan
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	elif Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	elif Input.is_action_pressed("move_right"):
		velocity.x += 1

	# Menormalisasi agar kecepatannya seragam dan menetapkan kecepatan
	velocity = velocity.normalized() * speed

	if velocity.length() > 0:
		last_direction = velocity.normalized()  # Menyimpan arah pergerakan terakhir

	self.velocity = velocity
	move_and_slide()  # Menggerakkan karakter

	update_animation(velocity)  # Menyesuaikan animasi berdasarkan kecepatan

# Fungsi untuk memperbarui animasi karakter
func update_animation(velocity: Vector2):
	if velocity.length() == 0:
		play_idle_animation()  # Animasi idle jika tidak ada pergerakan
	else:
		play_walk_animation(velocity)  # Animasi berjalan jika bergerak

# Fungsi untuk mengatur animasi berjalan
func play_walk_animation(velocity: Vector2):
	if velocity.y > 0.5:  # Arah ke bawah
		if velocity.x > 0.5:  # Arah ke kanan bawah
			animated_sprite.play("walk_right_down")
		elif velocity.x < -0.5:  # Arah ke kiri bawah
			animated_sprite.play("walk_left_down")
		else:
			animated_sprite.play("walk_down")
	
	elif velocity.y < -0.5:  # Arah ke atas
		if velocity.x > 0.5:  # Arah ke kanan atas
			animated_sprite.play("walk_right_up")
		elif velocity.x < -0.5:  # Arah ke kiri atas
			animated_sprite.play("walk_left_up")
		else:
			animated_sprite.play("walk_up")
	
	elif velocity.x > 0.5 and abs(velocity.y) < 0.5:  # Arah ke kanan
		animated_sprite.play("walk_right_down")
	
	elif velocity.x < -0.5 and abs(velocity.y) < 0.5:  # Arah ke kiri
		animated_sprite.play("walk_left_down")

# Fungsi untuk mengatur animasi idle
func play_idle_animation():
	if last_direction.y > 0.5:  # Arah idle ke bawah
		if last_direction.x > 0.5:  # Arah ke kanan bawah
			animated_sprite.play("idle_right_down")
		elif last_direction.x < -0.5:  # Arah ke kiri bawah
			animated_sprite.play("idle_left_down")
		else:
			animated_sprite.play("idle_down")
	
	elif last_direction.y < -0.5:  # Arah idle ke atas
		if last_direction.x > 0.5:  # Arah ke kanan atas
			animated_sprite.play("idle_right_up")
		elif last_direction.x < -0.5:  # Arah ke kiri atas
			animated_sprite.play("idle_left_up")
		else:
			animated_sprite.play("idle_up")
	
	elif last_direction.x > 0.5 and abs(last_direction.y) < 0.5:  # Arah idle ke kanan
		animated_sprite.play("idle_right_down")
	
	elif last_direction.x < -0.5 and abs(last_direction.y) < 0.5:  # Arah idle ke kiri
		animated_sprite.play("idle_left_down")
