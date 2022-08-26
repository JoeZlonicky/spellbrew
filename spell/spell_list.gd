extends Resource

class_name SpellList


const BASIC_SPELL = preload("res://spell/spells/basic_spell.gd")
const FLAMETHROWER = preload("res://spell/spells/flame_thrower.gd")
const INFERNO_BLAST =  preload("res://spell/spells/inferno_blast.gd")
const CROSS_FIRE = preload("res://spell/spells/cross_fire.gd")


static func get_spell_display_name(spell):
	if spell == BASIC_SPELL:
		return "Basic Spell"
	elif spell == FLAMETHROWER:
		return "Flamethrower"
	elif spell == INFERNO_BLAST:
		return "Inferno Blast"
	elif spell == CROSS_FIRE:
		return "Cross Fire"
