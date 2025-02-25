extends Node2D

@onready var player = get_node("/root/Game/Player/Hasagi")
@onready var path_2d = %Path2D
@onready var path_follow_2d = %PathFollow2D

func _ready():
	print("DEBUG: _ready() CALLED!")
	var player = get_node("/root/Game/Player/Hasagi")
	player.health_depleted.connect(_on_player_health_depleted)
	await get_tree().process_frame
	path_follow_2d.position = Vector2.ZERO
	print("DEBUG: Player Node:", player)

	
func _process(delta):
	path_2d.global_position = player.global_position
	print("Player Pos:", player.global_position, " | Path2D Pos:", %Path2D.global_position)
func spawn_mob():
	path_2d.global_position = player.global_position
	path_follow_2d.progress_ratio = randf()
	var new_mob = preload("res://mobv_2.tscn").instantiate()
	new_mob.global_position = path_follow_2d.global_position
	add_child(new_mob)

func _on_timer_timeout() -> void:
	spawn_mob()

func _on_player_health_depleted() -> void:
	%"GAME OVER".visible = true
	%"GameOverUI".visible = true
	get_tree().paused = true
#oke sudah aman pathfollow nya sudah aman,tapi masih ada yang ane,path follow nya tidak ditengah karaternya
