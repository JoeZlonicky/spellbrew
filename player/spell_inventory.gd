extends Node

class_name SpellInventory

const MAX_NUM_INGREDIENTS: int = 2

var ingredients: Array = []


func is_full() -> bool:
	return ingredients.size() >= MAX_NUM_INGREDIENTS


func add_ingredient(ingredient: Ingredient) -> void:
	ingredients.append(ingredient)


func empty() -> void:
	ingredients = []
