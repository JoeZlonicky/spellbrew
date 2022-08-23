extends KinematicBody2D


const MOVEMENT_SPEED: float = 60.0
const ACCELERATION_WEIGHT: float = 30.0  # Multiplied by physics delta to get lerp weight
const DECCELERATION_WEIGHT: float = 30.0  # Multiplied by physics delta to get lerp weight
const MAX_KNOCKBACK: float = 100.0
const KNOCKBACK_RECOVERY_RATE: float = 20.0  # Multiplied by physics delta to get lerp weight

var velocity: Vector2
var knockback: Vector2

onready var direction_node: Node2D = $Direction
onready var animation_state_machine: AnimationNodeStateMachinePlayback = $AnimationTree["parameters/playback"]
onready var wand = $Wand
onready var inventory = $Inventory
onready var input_handler = $InputHandler


# Handle movement
func _physics_process(delta: float) -> void:
	var movement: Vector2 = input_handler.get_movement_input_vector()
	
	# Accelerate to movement input or deccelerate to zero if no input
	if movement.length() > 0.1:
		velocity = lerp(velocity, movement.normalized() * MOVEMENT_SPEED, ACCELERATION_WEIGHT * delta)
		animation_state_machine.travel("walk")
	else:
		velocity = lerp(velocity, movement.normalized() * MOVEMENT_SPEED, DECCELERATION_WEIGHT * delta)
		animation_state_machine.travel("idle")
	
	# Apply knockback (comes from spells usually)
	velocity += knockback
	knockback = lerp(knockback, Vector2.ZERO, KNOCKBACK_RECOVERY_RATE * delta)
	if knockback.length() > 0.1:
		animation_state_machine.travel("walk")
	
	# Move
	velocity = move_and_slide(velocity)

	# Face wand direction
	direction_node.scale.x = wand.direction_sign * abs(direction_node.scale.x)


# Add knockback to be applied during following physics steps
func apply_knockback(knockback_vector: Vector2) -> void:
	knockback += knockback_vector
	knockback = knockback.limit_length(MAX_KNOCKBACK)
