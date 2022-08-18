extends "res://spell/spell.gd"


const BASIC_PROJECTILE: PackedScene = preload("res://spell/projectile/projectile.tscn")


# Just shoot a single projectile on cast
func _ready() -> void:
	var _projectile = shoot_projectile_from_wand(BASIC_PROJECTILE)
	queue_free()
