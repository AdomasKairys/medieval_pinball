extends StaticBody2D

@export var default_texture: Texture
@export var on_hit_texture: Texture
@export var sprite_scale := Vector2(1,1)
@export var time := 1.0

var default_sprite = Sprite2D.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(default_sprite)
	default_sprite.texture = default_texture
	default_sprite.scale = sprite_scale	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and body is RigidBody2D:
		default_sprite.texture = on_hit_texture
		var direction = (body.global_position - global_position).normalized()
		body.apply_impulse(-direction*100)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		await get_tree().create_timer(time).timeout
		default_sprite.texture = default_texture
