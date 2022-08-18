extends Area2D

signal interacted_with(player)

onready var prompt = $Prompt as TextureRect


func _physics_process(_delta) -> void:
	prompt.hide()
	
	for body in get_overlapping_bodies():
		if not body.is_in_group("player"):
			continue
		
		var player = body
		
		if is_interactable(player):
			prompt.show()
			if Input.is_action_just_pressed("interact"):
				interact(player)
		
		emit_signal("interacted_with", player)


func interact(_player) -> void:
	assert(false, "the method 'interact' is not overriden in '" + name + "'")


func is_interactable(_player) -> bool:
	assert(false, "the method 'is_interactable' is not overriden in '" + name + "'")
	return false
