extends HBoxContainer

class_name SpellInventory

var ingredient_1: Ingredient = null
var ingredient_2: Ingredient = null

onready var slot_1 = $IngredientSlot1
onready var slot_2 = $IngredientSlot2


func _ready():
	update_ingredient_display()


func is_full() -> bool:
	return ingredient_1 != null and ingredient_2 != null


func add_ingredient(ingredient: Ingredient) -> void:
	if ingredient_1 == null:
		ingredient_1 = ingredient
	elif ingredient_2 == null:
		ingredient_2 = ingredient
	update_ingredient_display()


func empty() -> void:
	ingredient_1 = null
	ingredient_2 = null
	update_ingredient_display()


func update_ingredient_display():
	slot_1.visible = ingredient_1 != null
	slot_2.visible = ingredient_2 != null
	
	if ingredient_1 != null:
		slot_1.color = ingredient_1.color
	if ingredient_2 != null:
		slot_2.color = ingredient_2.color
