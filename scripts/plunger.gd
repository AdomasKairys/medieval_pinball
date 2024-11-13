extends AnimatableBody2D

@export var squash_scale := 0.05

@export var launch_speed := 10000.0
@export var prime_speed := 20.0
@export var prime_distance := 25

var _prime := 0.0
var _release_speed := 0.0
var _start_pos: Vector2

var _tween: Tween

var _start_sprite_scale: Vector2
var _start_sprite_pos: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_start_pos = position
	_start_sprite_scale = $PlungerSprite.scale
	_start_sprite_pos = $PlungerSprite.position

func _input(event: InputEvent) -> void:
	if event.is_action("ui_down"):
		if _tween: _tween.kill()
		_tween = create_tween().set_parallel(true)
		_tween.set_trans(_tween.TRANS_LINEAR)
		_tween.set_process_mode(_tween.TWEEN_PROCESS_PHYSICS)
		if event.is_pressed():
			_tween.set_ease(_tween.EASE_IN)
			_tween.tween_property(
				self, 
				"position", 
				_start_pos+Vector2(0, prime_distance), 
				1/prime_speed)
			_tween.tween_property(
				$PlungerSprite, 
				"scale",  
				_start_sprite_scale - Vector2(0, squash_scale), 
				1/prime_speed)
		else:
			_tween.tween_property(
				self, 
				"position", 
				_start_pos, 
				1/launch_speed)
			_tween.tween_property(
				$PlungerSprite, 
				"scale",  
				_start_sprite_scale, 
				1/launch_speed)
