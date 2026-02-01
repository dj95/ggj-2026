class_name in_game_ui
extends Control

# state
var currentSeason = 0

@onready var previousSeasonIcon = %PrevSeasonIcon
@onready var currentSeasonIcon = %CurrentSeasonIcon
@onready var nextSeasonIcon = %NextSeasonIcon

const seasonNames = ["spring", "summer", "autumn", "winter"]

func _ready() -> void:
	currentSeason = 0
	
	previousSeasonIcon.texture = load("res://entities/player/art/masks/winter.png")
	currentSeasonIcon.texture = load("res://entities/player/art/masks/spring.png")
	nextSeasonIcon.texture = load("res://entities/player/art/masks/summer.png")


func _input(event: InputEvent) -> void:
	var season_changed = false
	
	if event.is_action_pressed("previous_season"):
		currentSeason = (currentSeason - 1)%4
		season_changed = true

	if event.is_action_pressed("next_season"):
		currentSeason = (currentSeason + 1) %4
		season_changed = true

	if season_changed:
		previousSeasonIcon.texture = load("res://entities/player/art/masks/"+seasonNames[(currentSeason - 1) % 4]+".png")
		currentSeasonIcon.texture = load("res://entities/player/art/masks/"+seasonNames[currentSeason]+".png")
		nextSeasonIcon.texture = load("res://entities/player/art/masks/"+seasonNames[(currentSeason + 1) % 4]+".png")

		SignalBus.emit_signal("season_changed", seasonNames[currentSeason])
