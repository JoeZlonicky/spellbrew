extends "res://interactable/interactable.gd"

const SPAWNABLE = [
	IngredientList.EYE_OF_NEWT,
	IngredientList.PURE_LIGHTNING
	# IngredientList.SLIME_BALL, 
]

export (int, -1, 1) var ingredient_override = -1  # For testing

var ingredient: Ingredient

onready var ingredient_sprite: Sprite = $IngredientSprite


# Spawns ingredients to be picked by a player
func _ready():
	randomize()
	if ingredient_override > -1:
		set_ingredient(SPAWNABLE[ingredient_override])
	else:
		set_ingredient(SPAWNABLE[randi() % SPAWNABLE.size()])


# Only allow interaction if there is an ingredient that can be picked up
func _is_interactable(player: Player):
	return not player.inventory.is_full() and ingredient


# Remove ingredient from table and add to player's inventory
func _interact(player: Player):
	player.inventory.add_ingredient(ingredient)
	set_ingredient(null)


# Set ingredient on table (or null for removing)
func set_ingredient(new_ingredient: Ingredient) -> void:
	ingredient = new_ingredient
	if new_ingredient == null:
		ingredient_sprite.texture = null
	else:
		ingredient_sprite.texture = new_ingredient.sprite
