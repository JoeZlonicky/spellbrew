extends Node2D

class_name Spell


# Use this as a template for making spells
# _ready() -> on casting spell
# _physics_process(delta) -> every physics frame
# queue_free() -> cleans up and lets know that spell is done casting

var player_cast_by: KinematicBody2D
var player_position_at_cast: Vector2
var wand_end_at_cast: Vector2
var mouse_position_at_cast: Vector2
var mouse_direction_at_cast: Vector2


func _ready() -> void:
	assert(player_cast_by)


func initialize(player: KinematicBody2D, script: Script, mouse_position: Vector2):
	set_script(script)
	player_cast_by = player
	player_position_at_cast = player.global_position
	wand_end_at_cast = player.wand.end.global_position
	mouse_position_at_cast = mouse_position
	mouse_direction_at_cast = (mouse_position_at_cast - player.wand.global_position).normalized()


func shoot_projectile_from_wand(projectile_scene: PackedScene):
	var projectile = projectile_scene.instance()
	projectile.direction = (get_global_mouse_position() - player_cast_by.wand.global_position).normalized()
	get_tree().root.add_child(projectile)
	projectile.global_position = player_cast_by.wand.end.global_position
