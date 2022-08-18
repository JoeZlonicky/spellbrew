extends Node


# For specifying spells easily
enum SPELL_LIST {BASIC_SPELL, FLAMETHROWER, INFERNO_BLAST}

# For attaching to spell instances
const SPELL_SCRIPTS = {
	SPELL_LIST.BASIC_SPELL: preload("res://spell/spells/basic_spell.gd"),
	SPELL_LIST.FLAMETHROWER: preload("res://spell/spells/flame_thrower.gd"),
	SPELL_LIST.INFERNO_BLAST: preload("res://spell/spells/inferno_blast.gd")
}


# Determines what spell is the result of specified ingredients
func get_spell_from_ingredients(_ingredient_1: Ingredient, _ingredient_2: Ingredient):
	pass
