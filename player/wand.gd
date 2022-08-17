extends Sprite

class_name Wand


const BASIC_SPELL := preload("res://spell/spells/basic_spell.gd")
const FLAMETHROWER_SPELL := preload("res://spell/spells/flame_thrower.gd")

var direction_sign: int = 1

onready var end = $End


func _physics_process(_delta) -> void:
	var looking_direction: Vector2 = _get_looking_direction()
	rotation = looking_direction.angle()

	if looking_direction.x > 0.1:
		direction_sign = 1
	elif looking_direction.x < -0.1:
		direction_sign = -1
	
	if Input.is_action_just_pressed("cast"):
		cast_spell(FLAMETHROWER_SPELL)


func cast_spell(spell_script: Script):
	var spell = Spell.new()
	spell.initialize(get_parent(), spell_script, get_global_mouse_position())
	add_child(spell)


func _get_looking_direction() -> Vector2:
	return (get_global_mouse_position() - global_position).normalized()
