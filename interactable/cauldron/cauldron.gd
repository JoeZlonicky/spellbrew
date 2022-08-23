extends "res://interactable/interactable.gd"



# Only allow interaction if player has enough ingredients
func is_interactable(player) -> bool:
	return player.inventory.is_full()


# Empty ingredients from player's inventory
func interact(player) -> void:
	player.inventory.empty()


func determine_spell(ingredient_1: Ingredient, ingredient_2: Ingredient):
	pass


func ingredient_comparison(ingredient_1: Ingredient, ingredient_2: Ingredient, to_1: Ingredient, to_2: Ingredient):
	if ingredient_1 == to_1 && ingredient_2 == to_2:
		return true
	if ingredient_2 == to_1 && ingredient_1 == to_2:
		return true
	return false
