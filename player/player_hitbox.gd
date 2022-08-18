extends Area2D


export (NodePath) var player_path

onready var player = get_node(player_path)


func _ready():
	assert(player, "Player hitbox does not know who it belongs to")  # Just to be safe
