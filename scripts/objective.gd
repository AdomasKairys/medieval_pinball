extends Node2D

@export var points := 10

func _on_body_entered(body: Node2D) -> void:
	GameManager.increase_score(points)
