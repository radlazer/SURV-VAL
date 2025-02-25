extends CanvasLayer

@onready var restart_button = %Restart
@onready var exit_button = %Exit

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	restart_button.pressed.connect(_on_restart_pressed)
	exit_button.pressed.connect(_on_exit_pressed)

func _on_restart_pressed():
	get_tree().paused = false 
	get_tree().reload_current_scene()  

func _on_exit_pressed():
	get_tree().quit() 
