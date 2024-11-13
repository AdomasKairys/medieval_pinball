extends Area2D

@export var default_texture: Texture
@export var on_hit_texture: Texture
@export var sprite_scale := Vector2(1,1)
@export var animation_up_duration := 1.0
@export var animation_down_duration := 2.0
@export var animation_up_distance := -400
@export var animation_down_distance := 4000
@export var points := 400

var _default_sprite = Sprite2D.new()
var _tween: Tween
var _is_hit = false;

func _ready() -> void:
	add_child(_default_sprite)
	_default_sprite.texture = default_texture
	_default_sprite.scale = sprite_scale	

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player") and body is not RigidBody2D or _is_hit:
		return
	_is_hit = true
	print(_is_hit)
	GameManager.increase_score(points)
	_default_sprite.texture = on_hit_texture
	if _tween: _tween.kill()
	_tween = create_tween().set_parallel(true)
	_tween.set_trans(_tween.TRANS_CUBIC)
	_tween.set_ease(_tween.EASE_IN)
	_tween.tween_property(self, "position", position+Vector2(0,-400), animation_up_duration)
	_tween.tween_property(self, "rotation", TAU, animation_up_duration).from(0)
	_tween.chain().tween_property(self, "position", position+Vector2(0,4000), animation_down_duration)
