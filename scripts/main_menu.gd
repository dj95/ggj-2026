extends Node

const GAME = preload("res://scenes/level_1.tscn")

func _on_button_play_pressed() -> void:
	get_tree().change_scene_to_packed(GAME)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
