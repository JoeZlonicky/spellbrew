extends Area2D

signal interacted_with(player)

onready var prompt = $Prompt as TextureRect


# Check for overlapping player and if they try to interact
func _physics_process(_delta: float) -> void:
	prompt.hide()
	
	for body in get_overlapping_bodies():
		var player: Player = body  # Will be null if not a player
		if not player:
			continue
		
		if _is_interactable(player):
			prompt.show()
			if player.input_handler.interact_pressed:
				_interact(player)
		
		emit_signal("interacted_with", player)


# Overriden by inherited scripts to determine interact behaviour
func _interact(_player: Player) -> void:
	assert(false, "the method 'interact' is not overriden in '" + name + "'")


# Overriden by inherited scripts to determine when to be interactable
func _is_interactable(_player: Player) -> bool:
	assert(false, "the method 'is_interactable' is not overriden in '" + name + "'")
	return false
