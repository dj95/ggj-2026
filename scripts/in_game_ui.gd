extends Control

var springIcon = load("res://assets/img/seasons/spring.png")
var summerIcon = load("res://assets/img/seasons/summer.png")
var autumnIcon = load("res://assets/img/seasons/autumn.png")
var winterIcon = load("res://assets/img/seasons/winter.png")

@onready var previousSeasonIcon = %PrevSeasonIcon
@onready var currentSeasonIcon = %CurrentSeasonIcon
@onready var nextSeasonIcon = %NextSeasonIcon

var seasons = [springIcon, summerIcon , autumnIcon, winterIcon ]
var currentSeason = 0

func _ready() -> void:
	currentSeason = 0
	previousSeasonIcon.texture = winterIcon
	currentSeasonIcon.texture = springIcon
	nextSeasonIcon.texture = summerIcon 

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("previous_season"):
		currentSeason = (currentSeason - 1)%3
	
	if event.is_action_pressed("next_season"):
		currentSeason = (currentSeason + 1) %3
		
	previousSeasonIcon.texture = seasons[(currentSeason - 1)%3]	
	currentSeasonIcon.texture = seasons[currentSeason]
	nextSeasonIcon.texture = seasons[(currentSeason + 1)%3]
