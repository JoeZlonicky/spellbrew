extends StaticBody2D


export (Array, Resource) var ingredients

var spawned_ingredient: Ingredient = null

onready var ingredient_sprite = $IngredientSprite


func _ready():
	spawned_ingredient = ingredients[randi() % len(ingredients)]
	ingredient_sprite.texture = spawned_ingredient.sprite
