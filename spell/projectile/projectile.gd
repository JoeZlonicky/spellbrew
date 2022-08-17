extends KinematicBody2D


export (float) var ROTATION_SPEED = -5.0
export (float) var SPEED = 150.0
export (float) var MAX_DISTANCE = -1.0  # Negative means no max distance

var direction: Vector2
var distance_travelled: float = 0.0

onready var sprite = $Sprite
onready var trail_particles = $TrailParticles
onready var explosion_particles = $ExplosionParticles
onready var collision_shape = $CollisionShape2D
onready var free_delay_timer = $FreeDelayTimer


func _physics_process(delta: float) -> void:
	sprite.rotation += ROTATION_SPEED * delta
	distance_travelled += SPEED * delta
	
	var collision = move_and_collide(direction.normalized() * SPEED * delta)
	if collision:
		collision.set_deferred("disabled", true)
		destroy()
	elif MAX_DISTANCE > 0.0 and distance_travelled >= MAX_DISTANCE:
		destroy()
	
#	Bounce code
#	if collision.normal.x > 0.1 or collision.normal.x < -0.1:
#		direction.x *= -1
#	if collision.normal.y > 0.1 or collision.normal.y < -0.1:
#		direction.y *= -1
#	bounces += 1


func destroy():
	set_physics_process(false)
	sprite.visible = false
	trail_particles.emitting = false
	explosion_particles.emitting = true
	free_delay_timer.start()


func _on_FreeDelayTimer_timeout():
	queue_free()
