extends Node


# For specifying spells easily
enum SPELL_LIST {BASIC_SPELL, FLAMETHROWER, INFERNO_BLAST}

# For attaching to spell instances
const SPELL_SCRIPTS = {
	SPELL_LIST.BASIC_SPELL: preload("res://spell/spells/basic_spell.gd"),
	SPELL_LIST.FLAMETHROWER: preload("res://spell/spells/flame_thrower.gd"),
	SPELL_LIST.INFERNO_BLAST: preload("res://spell/spells/inferno_blast.gd")
}

const _EYE_OF_NEWT = AL_IngredientManager.INGREDIENT_LIST.EYE_OF_NEWT
const _PURE_LIGHTNING = AL_IngredientManager.INGREDIENT_LIST.PURE_LIGHTNING
const _SLIME_BALL = AL_IngredientManager.INGREDIENT_LIST.SLIME_BALL

const SPELL_INGREDIENTS = {
	SPELL_LIST.BASIC_SPELL: [],
	SPELL_LIST.FLAMETHROWER: [_EYE_OF_NEWT, _EYE_OF_NEWT],
	SPELL_LIST.INFERNO_BLAST: [_PURE_LIGHTNING, _PURE_LIGHTNING]
	
}


# Determines what spell is the result of specified ingredients
func get_spell_from_ingredients(_ingredient_1: Ingredient, _ingredient_2: Ingredient):
	pass
