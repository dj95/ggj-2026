extends Node

@export var collision: bool = false

func _ready() -> void:
	get_node("Sprite2D/StaticBody2D/CollisionPolygon2D").disabled = !collision
