extends Spell


const BASIC_PROJECTILE = preload("res://spell/projectile/projectile.tscn")


func _ready():
	shoot_projectile_from_wand(BASIC_PROJECTILE)
	queue_free()
