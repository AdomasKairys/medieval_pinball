extends AnimatableBody2D

@export var is_left := false
@export var paddle_rotation_speed := 2.0
@export var rotation_max := 45.0
@export var rotation_min := 0.0

var _action := ""
var _rotation_dir := 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_left:
		_action = "ui_left"
		$PaddleSprite.scale.x = -$PaddleSprite.scale.x
		_rotation_dir = -1.0
	else:
		_action = "ui_right"
		_rotation_dir = 1.0
	
func _physics_process(delta) -> void:
	if Input.is_action_pressed(_action):
		rotation = lerp_angle(rotation, rotation_max*PI/180*_rotation_dir, paddle_rotation_speed*delta)
	else:
		rotation = lerp_angle(rotation, rotation_min*PI/180*_rotation_dir, paddle_rotation_speed*delta)
	
	
