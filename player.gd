extends CharacterBody2D

@export var speed = 1200
@export var jump_speed = -1800
@export var gravity = 4000
	

func _physics_process(delta):
	# Add gravity every frame
	velocity.y += gravity * delta

	# Input affects x axis only
	velocity.x = Input.get_axis("left", "right") * speed

	move_and_slide()

	# Only allow jumping when on the ground
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
