extends Node

@onready var background: Sprite2D = %Background

func _ready() -> void:
	SignalBus.connect("season_changed", Callable(self, "_season_changes"))


func _season_changes(season: String) -> void:
	var backgroundTexture = load("res://entities/structures/lake/art/lake.jpg")
	if season == "winter":
		backgroundTexture = load("res://entities/structures/lake/art/lake_frozen.jpg")
	
	background.texture = backgroundTexture
