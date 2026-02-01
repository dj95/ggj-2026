extends Node

# sprites
@onready var spriteSkyBG: Sprite2D = %SpriteSkyBG
@onready var spriteCloud1: Sprite2D = %SpriteCloud1
@onready var spriteCloud2: Sprite2D = %SpriteCloud2
@onready var spriteGrass1: Sprite2D = %SpriteGrass1

# audio
@onready var music: AudioStreamPlayer = %Music
@onready var atmo: AudioStreamPlayer = %Atmo
@onready var transition: AudioStreamPlayer = %Transition


func _ready() -> void:
	SignalBus.connect("season_changed", Callable(self, "_season_changes"))

	spriteSkyBG.texture = load("res://entities/backgrounds/level_1/art/sky/spring/1.png")
	spriteCloud1.texture = load("res://entities/backgrounds/level_1/art/sky/spring/3.png")
	spriteCloud2.texture = load("res://entities/backgrounds/level_1/art/sky/spring/4.png")
	spriteGrass1.texture = load("res://entities/backgrounds/level_1/art/grass/spring.png")
	
	music.stream = load("res://entities/backgrounds/level_1/sound/music/spring.mp3")
	atmo.stream = load("res://entities/backgrounds/level_1/sound/atmo/spring.wav")
	
	music.play()
	atmo.play()


func _season_changes(season: String) -> void:
	spriteSkyBG.texture = load("res://entities/backgrounds/level_1/art/sky/"+ season + "/1.png")
	spriteCloud1.texture = load("res://entities/backgrounds/level_1/art/sky/"+ season + "/3.png")
	spriteCloud2.texture = load("res://entities/backgrounds/level_1/art/sky/"+ season + "/4.png")
	spriteGrass1.texture = load("res://entities/backgrounds/level_1/art/grass/"+ season + ".png")

	transitionSoundScape(season)
		

func transitionSoundScape(season: String) -> void:
	transition.stream = load("res://entities/backgrounds/level_1/sound/transition/" + season + ".wav")
	transition.play()
	
	await get_tree().create_timer(2.0).timeout

	music.stream = load("res://entities/backgrounds/level_1/sound/music/" + season + ".mp3")
	atmo.stream = load("res://entities/backgrounds/level_1/sound/atmo/" + season + ".wav")
	
	music.play()
	atmo.play()
	
