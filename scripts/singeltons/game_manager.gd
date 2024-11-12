extends Node2D

signal score_changed
signal game_over

var _score :=0
var _high_score := 0
var _save_path := "user://player_data.ini"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_load()

func increase_score(points: int):
	_score += points
	if _score > _high_score:
		_high_score = _score
	emit_signal("score_changed")

func get_score() -> int:
	return _score

func get_high_score() -> int:
	return _high_score

func end_game():
	_save()
	emit_signal("game_over")

# To save data
func _save() -> void:
	var config_file := ConfigFile.new()

	config_file.set_value("Player", "_high_score", _score)

	var error := config_file.save(_save_path)
	if error:
		print("An error happened while saving data: ", error)

# To load data
func _load() -> void:
	var config_file := ConfigFile.new()
	var error := config_file.load(_save_path)

	if error:
		print("An error happened while loading data: ", error)
		return

	_high_score = config_file.get_value("Player", "_high_score", 0)
