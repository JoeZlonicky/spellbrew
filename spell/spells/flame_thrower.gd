extends "res://spell/spell.gd"


const SHORT_RANGE_PROJECTILE: PackedScene = preload("res://spell/projectile/short_range/short_range_projectile.tscn")
const TIME_BETWEEN_TICKS: float = 0.2
const ANGLE_SPREAD_DEGREES: float = 30.0
const SPELL_DURATION: float = 1.5
const NUM_PROJECTILES_PER_TICK: int = 4
 

# Send out waves of projectiles every TIME_BETWEEN_TICKS for SPELL_DURATION
func _ready() -> void:
	# Keeps track of spell duration
	var spell_timer = Timer.new()
	add_child(spell_timer)
	spell_timer.wait_time = SPELL_DURATION
	spell_timer.one_shot = true
	spell_timer.connect("timeout", self, "_on_spell_timer_timeout")
	spell_timer.start()
	
	# Ticks for waves to send out
	var tick_timer = Timer.new()
	add_child(tick_timer)
	tick_timer.wait_time = TIME_BETWEEN_TICKS
	tick_timer.connect("timeout", self, "_on_tick_timer_timeout")
	tick_timer.start()
	
	_on_tick_timer_timeout()  # First tick


# Sends out a spread of projectiles
func _on_tick_timer_timeout() -> void:
	for i in NUM_PROJECTILES_PER_TICK:
		var projectile = shoot_projectile_from_wand(SHORT_RANGE_PROJECTILE)
		var random_angle = projectile.direction.angle()
		random_angle += deg2rad(randf() * (ANGLE_SPREAD_DEGREES * 2.0) - ANGLE_SPREAD_DEGREES)
		projectile.direction = Vector2(cos(random_angle), sin(random_angle))
	

# Clean up once spell is done
func _on_spell_timer_timeout() -> void:
	queue_free()


func get_display_name() -> String:
	return "Flamethrower"
