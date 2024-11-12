extends Node2D

@export var points := 10

func _on_area_entered(area: Area2D) -> void:
	GameManager.increase_score(points)
