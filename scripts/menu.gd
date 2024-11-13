extends Control

func _ready() -> void:
	$RichTextLabel.text += str(GameManager.get_high_score())

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game_scene.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
