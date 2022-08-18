extends "res://interactable/interactable.gd"

export (Array, Resource) var ingredients

var ingredient: Ingredient = null

onready var ingredient_sprite: Sprite = $IngredientSprite


# Spawns ingredients to be picked by a player
func _ready():
	assert(ingredients.size() > 0, "Need to specify ingredient list for table")
	set_ingredient(ingredients[randi() % len(ingredients)])


# Only allow interaction if there is an ingredient that can be picked up
func is_interactable(player):
	return not player.inventory.is_full() and ingredient


# Remove ingredient from table and add to player's inventory
func interact(player):
	player.inventory.add_ingredient(ingredient)
	set_ingredient(null)


# Set ingredient on table (or null for removing)
func set_ingredient(new_ingredient: Ingredient) -> void:
	ingredient = new_ingredient
	ingredient_sprite.texture = null if new_ingredient == null else new_ingredient.sprite
