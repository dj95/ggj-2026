class_name Seasons
extends Node

static func get_season_index(season_name: String) -> int:
	var seasonIndex = {
		"spring": 0,
		"summer": 1,
		"autumn": 2,
		"winter": 3
	}

	return seasonIndex[season_name]
