extends CharacterBody2D

@export var speed = 250
@export var gravity = 40
@export var jump_force = 650
@export var glide_speed = 75

var jump_count := 0
var max_jumps := 2
var is_gliding := false

@onready var _animated_sprite = $AnimationPlayer

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
		
		# gliding
		if is_gliding:
			velocity.y += gravity * 0.3
			if velocity.y > glide_speed:
				velocity.y = glide_speed
				
		# regular jump
		else:
			velocity.y += gravity
			if velocity.y > 1000:
				velocity.y = 1000

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump_count = 0

		if jump_count == 0:
			velocity.y = -jump_force
			jump_count += 1

		elif jump_count == 1:
			is_gliding = true
			jump_count += 1

	# stop glide on jump release
	if Input.is_action_just_released("jump"):
		is_gliding = false

	move_and_slide()

	# movement
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction

	# flip animation and charactor when walking left and right
	if velocity.x < 0:
		$Sprite2D.flip_h = true
	elif velocity.x > 0:
		$Sprite2D.flip_h = false

	move_and_slide()
