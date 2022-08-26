extends "res://interactable/interactable.gd"

const SPAWNABLE = [
	IngredientList.EYE_OF_NEWT,
	IngredientList.PURE_LIGHTNING
	# IngredientList.SLIME_BALL, 
]
const PICKUP_TEXT = preload("res://interactable/table/pickup_text/pickup_text.tscn")

export (int, -1, 1) var ingredient_override = -1  # For testing

var ingredient: Ingredient

onready var ingredient_sprite: Sprite = $IngredientSprite
onready var pickup_text_spawn_point: Control = $PickupTextSpawnPoint


# Spawns ingredients to be picked by a player
func _ready():
	randomize()
	_on_RespawnTimer_timeout()


# Only allow interaction if there is an ingredient that can be picked up
func _is_interactable(player: Player):
	return not player.inventory.is_full() and ingredient


# Remove ingredient from table and add to player's inventory
func _interact(player: Player):
	player.inventory.add_ingredient(ingredient)
	var pickup_text = PICKUP_TEXT.instance()
	pickup_text_spawn_point.add_child(pickup_text)
	pickup_text.set_text(ingredient.display_name)
	set_ingredient(null)
	$RespawnTimer.start()


# Set ingredient on table (or null for removing)
func set_ingredient(new_ingredient: Ingredient) -> void:
	ingredient = new_ingredient
	if new_ingredient == null:
		ingredient_sprite.texture = null
	else:
		ingredient_sprite.texture = new_ingredient.sprite


func _on_RespawnTimer_timeout():
	if ingredient_override > -1:
		set_ingredient(SPAWNABLE[ingredient_override])
	else:
		set_ingredient(SPAWNABLE[randi() % SPAWNABLE.size()])
