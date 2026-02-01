extends Node2D

# configuration
@export var speed = 10

# state
var direction = 0
var isWinter = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var death_eyes: Label = %DeathEyes

func _ready() -> void:
	animation_player.play("swim")
	SignalBus.connect("season_changed", Callable(self, "_on_season_change"))

func _physics_process(_delta: float) -> void:
	if isWinter:
		animation_player.stop()
		death_eyes.visible = true
		return
		
	if !animation_player.is_playing():
		animation_player.play()
		death_eyes.visible = false
	
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
