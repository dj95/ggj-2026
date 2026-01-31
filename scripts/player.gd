extends CharacterBody2D

@export var speed = 300
@export var gravity = 40
@export var jump_force = 800
@export var glide_speed = 75

var jump_count := 0
var max_jumps := 2
var is_gliding := false

var paused = false
@onready var pauseScreen = $PauseScreen

@onready var _animated_sprite = $AnimationPlayer

func _input(event: InputEvent) -> void:
	if !pauseScreen.visible:
		if Input.is_action_pressed("pause"):
			pauseScreen.visible = true
			set_physics_process(false)
			paused = true

var current_season = "spring"

func _ready() -> void:
	SignalBus.connect("season_changed", Callable(self, "_season_changes"))

func _process(_delta: float) -> void:
	if Input.is_action_pressed("move_right"):
		_animated_sprite.play("walk")
	elif Input.is_action_pressed("move_left"):
		_animated_sprite.play("walk")
	else:
		_animated_sprite.stop()


func _physics_process(delta: float):
	if !is_on_floor():
		_animated_sprite.stop()

		if is_gliding:
			# gliding
			velocity.y += gravity * 0.3
			if velocity.y > glide_speed:
				velocity.y = glide_speed
		else:
			# regular jump
			velocity.y += gravity
			if velocity.y > 1000:
				velocity.y = 1000

	if Input.is_action_just_pressed("jump"):
		# reset on floor
		if is_on_floor():
			jump_count = 0 

		if jump_count == 0:
			velocity.y = -jump_force
			jump_count += 1
		elif jump_count == 1:
			
			# second jump
			if current_season == "autumn":
				is_gliding = true
			else:
				velocity.y = -jump_force
			jump_count += 1

	# stop gliding on jump release
	if Input.is_action_just_released("jump"):
		is_gliding = false

	# movement
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction

	# flip animation and charactor when walking left and right
	if velocity.x < 0:
		$Sprite2D.flip_h = true
	elif velocity.x > 0:
		$Sprite2D.flip_h = false

	move_and_slide()


func _on_resume_pressed() -> void:
	print("resume")
	pauseScreen.visible = false
	get_tree().paused = false
	set_process_input(true)
	set_physics_process(true)


func _on_quit_pressed() -> void:
	get_tree().quit()
	
	
func _season_changes(season):
	current_season = season
	#stop gliding when season changes
	is_gliding = false


func _on_main_menu_pressed() -> void:
	print("Main Menu")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
