extends KinematicBody2D


const MOVEMENT_SPEED: float = 60.0
const ACCELERATION_WEIGHT: float = 30.0  # Multiplied by physics delta to get lerp weight
const DECCELERATION_WEIGHT: float = 30.0  # Multiplied by physics delta to get lerp weight

var velocity: Vector2

onready var direction_node := get_node("%Direction") as Node2D
onready var wand := get_node("%Wand") as Sprite


func _physics_process(delta: float) -> void:
	var movement: Vector2 = _get_movement_input()
	
	if movement:
		velocity = lerp(velocity, movement.normalized() * MOVEMENT_SPEED, ACCELERATION_WEIGHT * delta)
	else:
		velocity = lerp(velocity, movement.normalized() * MOVEMENT_SPEED, DECCELERATION_WEIGHT * delta)
	
	velocity = move_and_slide(velocity)

	_update_wand_direction()


func _get_movement_input() -> Vector2:
	var movement := Vector2(0, 0)
	
	if Input.is_action_pressed("move_right"):
		movement.x += 1
	if Input.is_action_pressed("move_left"):
		movement.x -= 1
	if Input.is_action_pressed("move_up"):
		movement.y -= 1
	if Input.is_action_pressed("move_down"):
		movement.y += 1
	
	return movement


func _update_wand_direction() -> void:
	var looking_vector: Vector2 = (get_global_mouse_position() - wand.global_position).normalized()
	wand.rotation = looking_vector.angle()

	if looking_vector.x > 0.1:
		direction_node.scale.x = abs(direction_node.scale.x)
	elif looking_vector.x < -0.1:
		direction_node.scale.x = -abs(direction_node.scale.x)
