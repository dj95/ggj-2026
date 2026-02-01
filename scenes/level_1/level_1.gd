extends Node

@onready var timer: Timer = $Timer

const bird = preload("res://entities/animals/bird/bird.tscn")

func _ready() -> void:
	randomize()
	timer.timeout.connect(Callable(self, "_on_timer"))
	timer.start()

	
func _on_timer() -> void:
	print("timer")
	var shouldSpawn = randi() % 40 < 20
	if !shouldSpawn:
		return
	
	var birdChild = bird.instantiate()
	birdChild.speed = randi() % 10 + 4
	birdChild.scale = Vector2(10.0, 10.0)
	birdChild.position = Vector2(-200, randi() % 151 + 10)
	add_child(birdChild)
