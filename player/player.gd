extends KinematicBody2D

class_name Player


const MOVEMENT_SPEED: float = 60.0
const ACCELERATION_WEIGHT: float = 30.0  # Multiplied by physics delta to get lerp weight
const DECCELERATION_WEIGHT: float = 30.0  # Multiplied by physics delta to get lerp weight

var velocity: Vector2

onready var direction_node: Node2D = $Direction
onready var animation_state_machine: AnimationNodeStateMachinePlayback = $AnimationTree["parameters/playback"]
onready var wand: Wand = $Wand
onready var inventory: SpellInventory = $SpellInventory


func _physics_process(delta: float) -> void:
	var movement: Vector2 = _get_movement_input()
	
	if movement:
		velocity = lerp(velocity, movement.normalized() * MOVEMENT_SPEED, ACCELERATION_WEIGHT * delta)
		animation_state_machine.travel("walk")
	else:
		velocity = lerp(velocity, movement.normalized() * MOVEMENT_SPEED, DECCELERATION_WEIGHT * delta)
		animation_state_machine.travel("idle")
	
	velocity = move_and_slide(velocity)

	direction_node.scale.x = wand.direction_sign * abs(direction_node.scale.x)


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
