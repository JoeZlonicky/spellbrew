extends "res://interactable/interactable.gd"


func is_interactable(player: Player):
	return player.inventory.is_full()


func interact(player: Player):
	player.inventory.empty()
