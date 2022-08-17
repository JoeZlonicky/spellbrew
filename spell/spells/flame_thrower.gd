extends Spell


const SHORT_RANGE_PROJECTILE = preload("res://spell/projectile/short_range/short_range_projectile.tscn")
const TIME_BETWEEN_PROJECTILES = 0.1
const ANGLE_SPREAD_DEGREES = 30.0
const SPELL_DURATION = 3.0
 

func _ready():
	var spell_timer = Timer.new()
	add_child(spell_timer)
	spell_timer.wait_time = SPELL_DURATION
	spell_timer.one_shot = true
	spell_timer.connect("timeout", self, "_on_spell_timer_timeout")
	spell_timer.start()
	
	var tick_timer = Timer.new()
	add_child(tick_timer)
	tick_timer.wait_time = TIME_BETWEEN_PROJECTILES
	tick_timer.connect("timeout", self, "_on_tick_timer_timeout")
	tick_timer.start()


func _on_tick_timer_timeout():
	shoot_projectile_from_wand(SHORT_RANGE_PROJECTILE)


func _on_spell_timer_timeout():
	queue_free()
