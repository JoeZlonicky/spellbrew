extends Area2D

signal interacted_with(player)


onready var prompt = $Prompt as NinePatchRect


func _physics_process(_delta):
	prompt.hide()
	
	for player in get_overlapping_bodies():
		player = player as Player
		if not player:
			continue
		
		if is_interactable(player):
			prompt.show()
			if Input.is_action_just_pressed("interact"):
				interact(player)
		
		emit_signal("interacted_with", player)


func interact(player: Player) -> void:
	assert(false, "the method 'interact' is not overriden in '" + name + "'")


func is_interactable(player: Player) -> bool:
	assert(false, "the method 'is_interactable' is not overriden in '" + name + "'")
	return true
