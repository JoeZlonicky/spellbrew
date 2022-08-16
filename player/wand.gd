extends Sprite


var direction_sign: int = 1

func _physics_process(_delta) -> void:
	var looking_vector: Vector2 = (get_global_mouse_position() - global_position).normalized()
	rotation = looking_vector.angle()

	if looking_vector.x > 0.1:
		direction_sign = 1
	elif looking_vector.x < -0.1:
		direction_sign = -1
