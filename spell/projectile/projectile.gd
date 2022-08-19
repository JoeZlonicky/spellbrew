extends KinematicBody2D


export (float) var ROTATION_SPEED = -5.0
export (float) var SPEED = 150.0
export (float) var MAX_DISTANCE = -1.0  # Negative means no max distance

var direction: Vector2
var distance_travelled: float = 0.0
var player_cast_by = null
var player_color: Color

onready var sprite: Sprite = $Sprite
onready var trail_particles: Particles2D = $TrailParticles
onready var explosion_particles: Particles2D = $ExplosionParticles
onready var collision_shape: CollisionShape2D = $CollisionShape2D
onready var free_delay_timer: Timer = $FreeDelayTimer
onready var outline_sprite = $Sprite/Outline
onready var inner_sprite = $Sprite/Inner


# A projectile that will go till it hits something or travels MAX_DISTANCE
func _ready() -> void:
	assert(player_cast_by, "Projectile does not know who sent it")  # Just to be safe


# Move and rotate sprite
func _physics_process(delta: float) -> void:
	sprite.rotation += ROTATION_SPEED * delta
	distance_travelled += SPEED * delta
	
	var collision = move_and_collide(direction.normalized() * SPEED * delta)
	if collision:
		destroy()
	elif MAX_DISTANCE > 0.0 and distance_travelled > MAX_DISTANCE:
		destroy()


# Stop moving and play destroy animation
func destroy() -> void:
	set_physics_process(false)
	collision_shape.set_deferred("disabled", true)
	sprite.visible = false
	trail_particles.emitting = false
	explosion_particles.emitting = true
	free_delay_timer.start()


# Give enough time for explosion particles to emit before freeing
func _on_FreeDelayTimer_timeout() -> void:
	queue_free()


# Check for hitting player hitbox
func _on_Hitbox_area_entered(area) -> void:
	if area.is_in_group("player_hitbox") and area.player != player_cast_by:
		destroy()


func set_player_color(color: Color) -> void:
	player_color = color
	outline_sprite.self_modulate = color
	inner_sprite.self_modulate = color
	explosion_particles.self_modulate = color
