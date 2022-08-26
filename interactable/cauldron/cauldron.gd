extends "res://interactable/interactable.gd"


const SPELL_RECIPES = {
	SpellList.FLAMETHROWER: [IngredientList.EYE_OF_NEWT, IngredientList.EYE_OF_NEWT],
	SpellList.INFERNO_BLAST: [IngredientList.PURE_LIGHTNING, IngredientList.PURE_LIGHTNING],
	SpellList.CROSS_FIRE: [IngredientList.EYE_OF_NEWT, IngredientList.PURE_LIGHTNING]
}
const PICKUP_TEXT = preload("res://interactable/table/pickup_text/pickup_text.tscn")

onready var pickup_text_spawn_point: Control = $PickupTextSpawnPoint


# Only allow interaction if player has enough ingredients
func _is_interactable(player: Player) -> bool:
	return player.inventory.is_full()


# Use ingredients from player's inventory to create a spell
func _interact(player: Player) -> void:
	if not player.inventory.is_full():
		return
	
	var spell = _get_spell_from_ingredients(player.inventory.ingredient_1,
		player.inventory.ingredient_2)
	
	if spell:
		player.inventory.empty()
		player.wand.equip_spell(spell)
		
		var pickup_text = PICKUP_TEXT.instance()
		pickup_text_spawn_point.add_child(pickup_text)
		pickup_text.set_text(SpellList.get_spell_display_name(spell))


# Tries to find a matching spell recipe for the given ingredients
# Returns null if there is no matching recipe
func _get_spell_from_ingredients(ingredient_1: Ingredient, ingredient_2: Ingredient):
	for spell in SPELL_RECIPES:
		var recipe = SPELL_RECIPES[spell]
		if recipe[0] == ingredient_1 and recipe[1] == ingredient_2:
			return spell
		if recipe[1] == ingredient_1 and recipe[0] == ingredient_2:
			return spell
	return null
