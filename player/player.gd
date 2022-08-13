extends KinematicBody2D


const MOVEMENT_SPEED: float = 50.0
const ACCELERATION_WEIGHT: float = 30.0  # Multiplied by physics delta to get lerp weight
const DECCELERATION_WEIGHT: float = 30.0  # Multiplied by physics delta to get lerp weight

var velocity: Vector2

onready var transform_node = get_node("%Transform")


func _physics_process(delta: float) -> void:
	var movement: Vector2 = _get_movement_input()
	
	_update_facing_direction(movement.x)
	
	if movement:
		velocity = lerp(velocity, movement.normalized() * MOVEMENT_SPEED, ACCELERATION_WEIGHT * delta)
	else:
		velocity = lerp(velocity, movement.normalized() * MOVEMENT_SPEED, DECCELERATION_WEIGHT * delta)
	
	velocity = move_and_slide(velocity)


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


func _update_facing_direction(x_movement: float) -> void:
	if x_movement > 0.1:
		transform_node.scale.x = 1
	elif x_movement < -0.1:
		transform_node.scale.x = -1
