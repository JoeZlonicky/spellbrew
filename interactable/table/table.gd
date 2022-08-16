extends "res://interactable/interactable.gd"

export (Array, Resource) var ingredients

var ingredient: Ingredient = null

onready var ingredient_sprite = $IngredientSprite


func _ready():
	assert(ingredients.size() > 0, "Need to specify ingredient list for table")
	set_ingredient(ingredients[randi() % len(ingredients)])


func is_interactable(player: Player):
	return not player.inventory.is_full() and ingredient


func interact(player: Player):
	player.inventory.add_ingredient(ingredient)
	set_ingredient(null)


func set_ingredient(new_ingredient: Ingredient) -> void:
	ingredient = new_ingredient
	ingredient_sprite.texture = null if new_ingredient == null else new_ingredient.sprite
