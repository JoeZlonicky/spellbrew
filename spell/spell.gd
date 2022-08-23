extends Node2D


var player_cast_by
var player_position_at_cast: Vector2
var player_color: Color
var wand_end_at_cast: Vector2
var direction_at_cast: Vector2


# Use this as a template for making spells
# _ready() -> on casting spell
# _physics_process(delta) -> every physics frame
# Make sure to queue_free() as it cleans up and signals the spell is done casting
# 	(can connect to tree_exited)
func _ready() -> void:
	assert(player_cast_by, "Spell does not know who cast it")  # Just to be safe


# Set spell script and some boilerplate variables so they can be used by spells
func initialize(player: KinematicBody2D, mouse_position: Vector2, color: Color):
	player_cast_by = player
	player_position_at_cast = player.global_position
	player_color = color
	wand_end_at_cast = player.wand.cast_point.global_position
	direction_at_cast = (mouse_position - player.wand.global_position).normalized()


# Helper function that simply spawns a projectile at the end of the wand
# It returns the projectile it created so it can be adjusted if needed (like altering direction)
func shoot_projectile_from_wand(projectile_scene: PackedScene) -> KinematicBody2D:
	var projectile = projectile_scene.instance()
	projectile.direction = (get_global_mouse_position() - player_cast_by.wand.global_position).normalized()
	projectile.player_cast_by = player_cast_by
	get_tree().root.add_child(projectile)
	projectile.set_player_color(player_color)
	projectile.global_position = player_cast_by.wand.cast_point.global_position
	return projectile


# Helper function to apply knockback to caster
# Nice when you want to give a spell more pow
func apply_knockback_to_caster(knockback: Vector2):
	player_cast_by.apply_knockback(knockback)
