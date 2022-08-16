extends StaticBody2D

onready var prompt = $Prompt as Label
onready var interact_area = $InteractArea as Area2D


func _physics_process(_delta):
	prompt.hide()
	
	for player in interact_area.get_overlapping_bodies():
		player = player as Player
		if not player:
			continue
		
		if player.inventory.is_full():
			prompt.show()
		
		if Input.is_action_just_pressed("interact"):
			player.inventory.empty()
