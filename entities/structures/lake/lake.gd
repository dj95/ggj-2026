extends Area2D

# editor configuration
@export var underWaterGravity = 2
@export var underWaterJumpForce = 200

# state
var savedGravity = 0
var savedJumpForce = 0
var players: Array[CharacterBody2D] = []
var isWinter: bool = false

@onready var background: Sprite2D = %Background
@onready var ice_shape: CollisionShape2D = $"../Ice/CollisionShapeIce"


func _ready() -> void:
	SignalBus.connect("season_changed", Callable(self, "_season_changes"))


func _process(_delta: float) -> void:
	for player in players:
		if isWinter && player.is_swimming:
			_player_disable_swimming(player)
		
		if !isWinter && !player.is_swimming:
			_player_enable_swimming(player)


func _season_changes(season: String) -> void:
	isWinter = season == "winter"
	ice_shape.disabled = !isWinter
	
	var backgroundTexture = load("res://entities/structures/lake/art/lake.jpg")
	if isWinter:
		backgroundTexture = load("res://entities/structures/lake/art/lake_frozen.jpg")
	background.texture = backgroundTexture


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		players.append(body)


func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.is_swimming:
			_player_disable_swimming(body)

		players.erase(body)


func _player_enable_swimming(player: CharacterBody2D) -> void:
	savedGravity = player.gravity
	player.gravity = underWaterGravity
	
	savedJumpForce = player.jump_force
	player.jump_force = underWaterJumpForce
	
	player.is_swimming = true


func _player_disable_swimming(player: CharacterBody2D) -> void:
	player.gravity = savedGravity
	player.jump_force = savedJumpForce
	player.is_swimming = false
