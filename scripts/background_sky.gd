extends Node

var springBG = load("res://assets/img/sky/free-sky-with-clouds-background-pixel-art-set/Clouds/Clouds 2/1.png")
var summerBG = load("res://assets/img/sky/free-sky-with-clouds-background-pixel-art-set/Clouds/Clouds 5/1.png")
var autumnBG = load("res://assets/img/sky/free-sky-with-clouds-background-pixel-art-set/Clouds/Clouds 7/1.png")
var winterBG = load("res://assets/img/sky/free-sky-with-clouds-background-pixel-art-set/Clouds/Clouds 3/1.png")

var springCloud1 = load("res://assets/img/sky/free-sky-with-clouds-background-pixel-art-set/Clouds/Clouds 2/3.png")
var summerCloud1 = load("res://assets/img/sky/free-sky-with-clouds-background-pixel-art-set/Clouds/Clouds 5/3.png")
var autumnCloud1 = load("res://assets/img/sky/free-sky-with-clouds-background-pixel-art-set/Clouds/Clouds 7/3.png")
var winterCloud1 = load("res://assets/img/sky/free-sky-with-clouds-background-pixel-art-set/Clouds/Clouds 3/3.png")

var springCloud2 = load("res://assets/img/sky/free-sky-with-clouds-background-pixel-art-set/Clouds/Clouds 2/4.png")
var summerCloud2 = load("res://assets/img/sky/free-sky-with-clouds-background-pixel-art-set/Clouds/Clouds 5/4.png")
var autumnCloud2 = load("res://assets/img/sky/free-sky-with-clouds-background-pixel-art-set/Clouds/Clouds 7/4.png")
var winterCloud2 = load("res://assets/img/sky/free-sky-with-clouds-background-pixel-art-set/Clouds/Clouds 3/4.png")

var springGrass1 = load("res://assets/img/grass/Grass4-Loop.png")
var summerGrass1 = load("res://assets/img/grass/Grass1-LoopA.png")
var autumnGrass1 = load("res://assets/img/grass/Grass3-Loop.png")
var winterGrass1 = load("res://assets/img/grass/Grass2-Loop.png")

@onready var spriteSkyBG = %SpriteSkyBG
@onready var spriteCloud1 = %SpriteCloud1
@onready var spriteCloud2 = %SpriteCloud2
@onready var spriteGrass1 = %SpriteGrass1

var seasonIndex = {
	"spring": 0,
	"summer": 1,
	"autumn": 2,
	"winter": 3
}

var seasonBG = [springBG, summerBG, autumnBG, winterBG]
var seasonCloud1 = [springCloud1, summerCloud1, autumnCloud1, winterCloud1]
var seasonCloud2 = [springCloud2, summerCloud2, autumnCloud2, winterCloud2]
var seasonGrass1 = [springGrass1, summerGrass1, autumnGrass1, winterGrass1]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("season_changed", Callable(self, "_season_changes"))

	var currentSeason = 0

	spriteSkyBG.texture = seasonBG[currentSeason]
	spriteCloud1.texture = seasonCloud1[currentSeason]
	spriteCloud2.texture = seasonCloud2[currentSeason]
	spriteGrass1.texture = seasonGrass1[currentSeason]

func _season_changes(season: String):
	var currentSeason = seasonIndex[season]

	spriteSkyBG.texture = seasonBG[currentSeason]
	spriteCloud1.texture = seasonCloud1[currentSeason]
	spriteCloud2.texture = seasonCloud2[currentSeason]
	spriteGrass1.texture = seasonGrass1[currentSeason]
