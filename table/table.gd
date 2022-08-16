extends StaticBody2D


export (Array, Resource) var ingredients

var ingredient: Ingredient = null

onready var ingredient_sprite = $IngredientSprite
onready var prompt = $Prompt
onready var interact_area = $InteractArea


func _ready():
	set_ingredient(ingredients[randi() % len(ingredients)])


func _physics_process(_delta):
	prompt.hide()
	
	for player in interact_area.get_overlapping_bodies():
		player = player as Player
		if not player:
			continue
		
		if not player.inventory.is_full() and ingredient:
			prompt.show()
		
		if Input.is_action_just_pressed("interact"):
			player.inventory.add_ingredient(ingredient)
			set_ingredient(null)


func set_ingredient(new_ingredient: Ingredient) -> void:
	ingredient = new_ingredient
	ingredient_sprite.texture = null if new_ingredient == null else new_ingredient.sprite
