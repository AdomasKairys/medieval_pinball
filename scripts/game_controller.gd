extends Node2D

@export var score_text: RichTextLabel
@export var high_score_text: RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	high_score_text.text = "High score: " + str(GameManager.get_high_score())
	GameManager.connect("score_changed", _on_score_changed)
	GameManager.connect("game_over", _on_game_over)

func _on_score_changed():
	score_text.text = str(GameManager.get_score())

func _on_game_over():
	get_tree().reload_current_scene()
