extends KinematicBody2D


const ROTATION_SPEED: float = -5.0
const SPEED: float = 150.0

var direction: Vector2
var bounces = 0

onready var sprite = $Sprite
onready var trail_particles = $TrailParticles
onready var explosion_particles = $ExplosionParticles
onready var collision_shape = $CollisionShape2D


func _physics_process(delta: float) -> void:
	sprite.rotation += ROTATION_SPEED * delta
	
	var collision = move_and_collide(direction.normalized() * SPEED * delta)
	if collision:
		if bounces > 0:
			collision.set_deferred("disabled", true)
			set_physics_process(false)
			sprite.visible = false
			trail_particles.emitting = false
			explosion_particles.emitting = true
			return
		
		if collision.normal.x > 0.1 or collision.normal.x < -0.1:
			direction.x *= -1
		if collision.normal.y > 0.1 or collision.normal.y < -0.1:
			direction.y *= -1
		bounces += 1
