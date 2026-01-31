extends Node

@onready var floorModulate = $Sprite2D
var seasonIndex = {
	"spring": 0,
	"summer": 1,
	"autumn": 2,
	"winter": 3
}
var seasonModulate = [
	Color("9bff70"), 
	Color("ffe19c"), 
	Color("9bff70"), 
	Color("9bff70")
]

func _ready() -> void:
	SignalBus.connect("season_changed", Callable(self, "_on_season_change"))
	
func _on_season_change(season: String) -> void:
	var currentSeason = seasonIndex[season]
	# floorModulate.modulate = seasonModulate[currentSeason]
