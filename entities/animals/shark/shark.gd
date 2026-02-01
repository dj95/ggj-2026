extends Node2D

# configuration
@export var speed = 10

# state
var direction = 0
var isWinter = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var death_eyes_right: Label = %DeathEyesRight
@onready var death_eyes_left: Label = %DeathEyesLeft


func _ready() -> void:
	animation_player.play("swim")
	SignalBus.connect("season_changed", Callable(self, "_on_season_change"))

func _physics_process(_delta: float) -> void:
	if isWinter:
		animation_player.stop()
		if direction == 0:
			death_eyes_right.visible = true
		if direction == 1:
			death_eyes_left.visible = true
		return
		
	if !animation_player.is_playing():
		if direction == 0:
			death_eyes_right.visible = false
		if direction == 1:
			death_eyes_left.visible = false
		animation_player.play()
	
	if position.x + speed > 7500:
		direction = 1
		sprite_2d.flip_h = true

	if position.x - speed < 5950:
		direction = 0
		sprite_2d.flip_h = false
		
	if direction == 0:
		position.x += speed
	if direction == 1:
		position.x -= speed
		
func _on_season_change(season: String) -> void:
	isWinter = season == "winter"
