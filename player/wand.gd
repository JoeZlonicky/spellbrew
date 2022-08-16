extends Sprite


const BASIC_PROJECTILE = preload("res://spell/projectile/projectile.tscn")


var direction_sign: int = 1

onready var end = $End


func _physics_process(_delta) -> void:
	var looking_direction: Vector2 = _get_looking_direction()
	rotation = looking_direction.angle()

	if looking_direction.x > 0.1:
		direction_sign = 1
	elif looking_direction.x < -0.1:
		direction_sign = -1
	
	if Input.is_action_just_pressed("cast"):
		cast_basic_spell()


func cast_basic_spell() -> void:
	var cast_spell = BASIC_PROJECTILE.instance()
	cast_spell.direction = _get_looking_direction()
	get_tree().root.add_child(cast_spell)
	cast_spell.global_position = end.global_position


func _get_looking_direction() -> Vector2:
	return (get_global_mouse_position() - global_position).normalized()
