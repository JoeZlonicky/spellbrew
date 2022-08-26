extends "res://spell/spell.gd"


const INFERNO_PROJECTILE: PackedScene = preload("res://spell/projectile/inferno/inferno_projectile.tscn")

const TOTAL_NUM_PROJECTILES: int = 3
const TIME_BETWEEN_PROJECTILES: float = 0.5
const CASTER_KNOCKBACK_AMOUNT: float = 100.0

var num_projectiles_cast: int = 0


# Cast TOTAL_NUM_PROJECTILES with a delay of TIME_BETWEEN_PROJECTILES between
func _ready() -> void:
	cast_inferno_projectile()
	
	# Ticks for following projectiles
	var repeat_timer = Timer.new()
	repeat_timer.wait_time = TIME_BETWEEN_PROJECTILES
	add_child(repeat_timer)
	repeat_timer.connect("timeout", self, "_on_spell_timer_timeout")
	repeat_timer.start()


# Follow up projectile(s)
func _on_spell_timer_timeout() -> void:
	cast_inferno_projectile()


# Send out a projectile and apply knockback backwards
func cast_inferno_projectile() -> void:
	var projectile = shoot_projectile_from_wand(INFERNO_PROJECTILE)
	apply_knockback_to_caster(-projectile.direction.normalized() * CASTER_KNOCKBACK_AMOUNT)
	num_projectiles_cast += 1
	
	if num_projectiles_cast == TOTAL_NUM_PROJECTILES:
		queue_free()


func get_display_name() -> String:
	return "Inferno Blast"
