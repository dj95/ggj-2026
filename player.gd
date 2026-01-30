extends CharacterBody2D

@export var speed = 400

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	if input_direction != Vector2.ZERO:
		print("input: ", input_direction)
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
