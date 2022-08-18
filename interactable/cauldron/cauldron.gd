extends "res://interactable/interactable.gd"


# Only allow interaction if player has enough ingredients
func is_interactable(player) -> bool:
	return player.inventory.is_full()


# Empty ingredients from player's inventory
func interact(player) -> void:
	player.inventory.empty()
