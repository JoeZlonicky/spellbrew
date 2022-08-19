extends Sprite


const SPELL = preload("res://spell/spell.gd")

var direction_sign: int = 1
var is_casting_spell: bool = false
var held_spell: int = AL_SpellManager.SPELL_LIST.BASIC_SPELL
var player_color: Color

onready var cast_point: Position2D = $CastPoint
onready var active_spells_node: Node2D = $ActiveSpells  # Just for organization
onready var basic_spell_cooldown_timer: Timer = $BasicSpellCooldownTimer  # How often the basic spell can be cast


# Follow mouse and handle spell casting
func _physics_process(_delta) -> void:
	var looking_direction: Vector2 = _get_looking_direction()
	rotation = looking_direction.angle()

	if looking_direction.x > 0.1:
		direction_sign = 1
	elif looking_direction.x < -0.1:
		direction_sign = -1
	
	if Input.is_action_just_pressed("cast") and not is_casting_spell:
		if held_spell == AL_SpellManager.SPELL_LIST.BASIC_SPELL:
			if basic_spell_cooldown_timer.is_stopped():
				cast_held_spell()
				is_casting_spell = true
				basic_spell_cooldown_timer.start()
		else:
			cast_held_spell()
			is_casting_spell = true


func cast_held_spell() -> void:
	var spell = SPELL.new()
	spell.set_script(AL_SpellManager.SPELL_SCRIPTS[held_spell])
	spell.initialize(get_parent(), get_global_mouse_position(), player_color)
	active_spells_node.add_child(spell)
	spell.connect("tree_exited", self, "_on_spell_tree_exited")


func _get_looking_direction() -> Vector2:
	return (get_global_mouse_position() - global_position).normalized()


func _on_spell_tree_exited() -> void:
	is_casting_spell = false


func set_player_color(color: Color) -> void:
	player_color = color
