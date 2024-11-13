extends StaticBody2D

@export var hit_count := 3
@export var hit_score:= 10
@export var break_score := 50
@export var bounce_impulse := 100.0

var _current_hit_count := 0
var _is_destroyed = false

func _disable_node():
	process_mode = Node.PROCESS_MODE_DISABLED
	hide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player") and body is not RigidBody2D:
		return
	_current_hit_count += 1
	
	var direction = (body.global_position - global_position).normalized()
	body.apply_impulse(-direction*bounce_impulse)
	
	if _current_hit_count > hit_count and not _is_destroyed: 
		_is_destroyed = true
		GameManager.increase_score(break_score)
		call_deferred("_disable_node")
		return
	GameManager.increase_score(hit_score)
