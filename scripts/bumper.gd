extends StaticBody2D

@export var default_texture: Texture
@export var on_hit_texture: Texture
@export var sprite_scale := Vector2(1,1)
@export var hit_duration := 1.0
@export var bounce_impulse := 100.0

var _default_sprite = Sprite2D.new()
var _timer = Timer.new()

func _ready() -> void:
	add_child(_default_sprite)
	add_child(_timer)
	_default_sprite.texture = default_texture
	_default_sprite.scale = sprite_scale	
	_timer.one_shot = true
	_timer.timeout.connect(_on_hit_timeout)
	

func _on_hit_timeout():
	_default_sprite.texture = default_texture

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player") and body is not RigidBody2D:
		return
	_default_sprite.texture = on_hit_texture
	var direction = (body.global_position - global_position).normalized()
	body.apply_impulse(-direction*bounce_impulse)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		_timer.start(hit_duration)
