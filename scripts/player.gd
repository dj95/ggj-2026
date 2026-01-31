extends CharacterBody2D

@export var speed = 300
@export var gravity = 40
@export var jump_force = 800
@export var glide_speed = 175

var jump_count := 0
var max_jumps := 2
var is_gliding := false

var paused = false

var springMusic = load("res://assets/audio/GGJ1-1-Frühling.mp3")
var summerMusic = load("res://assets/audio/GGJ1-1-Sommer.mp3")
var autumnMusic = load("res://assets/audio/GGJ1-1-Herbst.mp3")
var winterMusic = load("res://assets/audio/GGJ1-1-Winter.mp3")

var springAtmo = load("res://assets/audio/atmo/spring_atmoLoop.wav")
var summerAtmo = load("res://assets/audio/atmo/summer_atmoLoop.wav")
var autumnAtmo = load("res://assets/audio/atmo/autum_atmoLoop.wav")
var winterAtmo = load("res://assets/audio/atmo/winter_atmoLoop.wav")

var seasonIndex = {
	"spring": 0,
	"summer": 1,
	"autumn": 2,
	"winter": 3,
}

var seasonMusic = [springMusic, summerMusic, autumnMusic, winterMusic]
var seasonAtmo = [springAtmo, summerAtmo, autumnAtmo, winterAtmo]

@onready var pauseScreen = $PauseScreen
@onready var _animated_sprite = $AnimationPlayer
@onready var backgroundMusic = %Level1BackgroundMusic
@onready var backgroundAtmo = %Level1AtmoMusic

func _input(event: InputEvent) -> void:
	if !pauseScreen.visible:
		if Input.is_action_pressed("pause"):
			pauseScreen.visible = true
			set_physics_process(false)
			paused = true

var current_season = "spring"

func _ready() -> void:
	SignalBus.connect("season_changed", Callable(self, "_season_changes"))
	backgroundMusic.stream = springMusic
	backgroundMusic.play()

	backgroundAtmo.stream = springAtmo
	backgroundAtmo.play()

func _process(_delta: float) -> void:
	if Input.is_action_pressed("move_right"):
		_animated_sprite.play("walk")
	elif Input.is_action_pressed("move_left"):
		_animated_sprite.play("walk")
	else:
		_animated_sprite.stop()


func _physics_process(delta: float):
	print(self.global_position)
	if self.global_position.y > 1000:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
		
	if !is_on_floor():
		_animated_sprite.stop()

		velocity.y += gravity
		if is_gliding:
			# gliding
			if velocity.y > glide_speed:
				velocity.y = glide_speed
		else:
			# regular jump
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
				velocity.y = -jump_force
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

	var currentSeasonIndex = seasonIndex[season]
	backgroundMusic.stream = seasonMusic[currentSeasonIndex]
	backgroundMusic.play()

	backgroundAtmo.stream = seasonAtmo[currentSeasonIndex]
	backgroundAtmo.play()


func _on_main_menu_pressed() -> void:
	print("Main Menu")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
