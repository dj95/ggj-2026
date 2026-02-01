class_name MainMenu
extends Node

const GAME = preload("res://scenes/level_1.tscn")

@onready var clickPlayer = %ClickPlayer

func _ready() -> void:
	clickPlayer.stream = load("res://scenes/main_menu/sound/menuClick_1.wav")


func _on_button_play_pressed() -> void:
	clickPlayer.play()

	get_tree().change_scene_to_packed(GAME)


func _on_quit_button_pressed() -> void:
	clickPlayer.play()

	get_tree().quit()
