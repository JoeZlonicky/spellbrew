extends Sprite


const SPELL = preload("res://spell/spell.gd")
const RIGHT_STICK_LOOK_THRESHOLD: float = 0.3

export (NodePath) var input_handler_path

var direction_sign: int = 1
var is_casting_spell: bool = false
var held_spell: GDScript = SpellList.BASIC_SPELL
var player_color: Color
var current_looking_direction: Vector2 = Vector2.RIGHT

onready var cast_point: Position2D = $CastPoint
onready var active_spells_node: Node2D = $ActiveSpells  # Just for organization
onready var basic_spell_cooldown_timer: Timer = $BasicSpellCooldownTimer  # How often the basic spell can be cast
onready var input_handler = get_node(input_handler_path)


# Follow mouse and handle spell casting
func _physics_process(_delta) -> void:
	update_current_looking_direction()
	
	rotation = current_looking_direction.angle()
	if current_looking_direction.x > 0.1:
		direction_sign = 1
	elif current_looking_direction.x < -0.1:
		direction_sign = -1
	
	if input_handler.cast_pressed and not is_casting_spell:
		if held_spell == SpellList.BASIC_SPELL:
			if basic_spell_cooldown_timer.is_stopped():
				cast_held_spell()
				is_casting_spell = true
				basic_spell_cooldown_timer.start()
		else:
			cast_held_spell()
			is_casting_spell = true


func cast_held_spell() -> void:
	var spell = SPELL.new()
	spell.set_script(held_spell)
	spell.initialize(get_parent())
	active_spells_node.add_child(spell)
	spell.connect("tree_exited", self, "_on_spell_tree_exited")


func update_current_looking_direction() -> void:
	if input_handler.is_kbm():
		current_looking_direction = (get_global_mouse_position() - global_position).normalized()
	else:
		var right_stick = input_handler.get_right_stick_vector()
		if right_stick.length() > RIGHT_STICK_LOOK_THRESHOLD:
			current_looking_direction = right_stick.normalized()


func _on_spell_tree_exited() -> void:
	is_casting_spell = false
	held_spell = SpellList.BASIC_SPELL


func set_player_color(color: Color) -> void:
	self_modulate = color
	player_color = color


func equip_spell(spell: GDScript) -> void:
	held_spell = spell
