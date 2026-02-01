extends Node2D

@export var speed = 2
@export var killItself = false

var turned = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_player.play("fly")


func _physics_process(_delta: float) -> void:
	if killItself && position.x > 2250:
		if !turned:
			animation_player.stop()
			await get_tree().create_timer(0.5).timeout
			turned = true
		position.y += (speed * 10)
		return
	position.x += speed
