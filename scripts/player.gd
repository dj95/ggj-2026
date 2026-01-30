extends CharacterBody2D

@export var speed = 300
@export var gravity = 40
@export var jump_force = 800
var isInFirstJump = false

@onready var _animated_sprite = $PlayerRunAnimation

func _process(delta: float) -> void:
	if Input.is_action_pressed("move_right"):
		_animated_sprite.play("run")
	elif Input.is_action_pressed("move_left"):
		_animated_sprite.play("run")
	else:
		_animated_sprite.stop()

func _physics_process(delta):
	# gravity - pull me down
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	
	# jump
	if Input.is_action_just_pressed("jump") && (is_on_floor() || isInFirstJump):
		isInFirstJump = !isInFirstJump
		velocity.y = -jump_force
	
	# movement
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction
	
	# flip animation and charactor when walking left and right
	if velocity.x < 0:
		_animated_sprite.flip_h = true
	elif velocity.x > 0:
		_animated_sprite.flip_h = false
	
	move_and_slide()
