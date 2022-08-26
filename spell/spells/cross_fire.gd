extends "res://spell/spell.gd"

const BASIC_PROJECTILE: PackedScene = preload("res://spell/projectile/projectile.tscn")

const NUM_TICKS: int = 5
const TIME_BETWEEN_TICKS: float = 0.25
const START_DISTANCE = 10.0  # Start a bit spaced out from player
const Y_OFFSET = -8.0  # Want to cast from roughly the center of the player sprite

var is_diagonal_next: bool = true  # Will go back and forth
var num_ticks: int = 0  # Ends when reachs NUM_TICKS


# Alternate between sending out 4 diagonal projectiles and 4 straight projectiles
func _ready() -> void:
	_on_spell_timer_timeout()
	
	# Ticks for following projectiles
	var repeat_timer = Timer.new()
	repeat_timer.wait_time = TIME_BETWEEN_TICKS
	add_child(repeat_timer)
	repeat_timer.connect("timeout", self, "_on_spell_timer_timeout")
	repeat_timer.start()


# Follow up projectiles
func _on_spell_timer_timeout() -> void:
	if is_diagonal_next:
		cast_diagonal_projectiles()
	else:
		cast_straight_projectiles()


# Send out projectiles in the 4 diagonal directions
func cast_diagonal_projectiles() -> void:
	cast_projectile_at_angle(PI/4.0)
	cast_projectile_at_angle(3.0*PI/4.0)
	cast_projectile_at_angle(5.0*PI/4.0)
	cast_projectile_at_angle(7.0*PI/4.0)

	is_diagonal_next = false
	
	num_ticks += 1
	if num_ticks == NUM_TICKS:
		queue_free()


# Send out projectiles in the horizontal and vertical axi
func cast_straight_projectiles() -> void:
	cast_projectile_at_angle(0.0)
	cast_projectile_at_angle(PI/2.0)
	cast_projectile_at_angle(PI)
	cast_projectile_at_angle(3.0*PI/2.0)
	
	is_diagonal_next = true
	
	num_ticks += 1
	if num_ticks == NUM_TICKS:
		queue_free()


# Send projectile at given angle from player and with correct position offset
func cast_projectile_at_angle(angle: float):
	var projectile = shoot_projectile_from_wand(BASIC_PROJECTILE)
	projectile.direction = Vector2(cos(angle), sin(angle))
	projectile.global_position = player_cast_by.global_position
	projectile.global_position += projectile.direction.normalized() * START_DISTANCE
	projectile.global_position.y += Y_OFFSET


func get_display_name() -> String:
	return "Crossfire"
