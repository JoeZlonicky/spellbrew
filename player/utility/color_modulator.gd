tool
extends Node

export (Color) var modulation = Color(2.5, 0.5, 0.5) setget set_modulation 
export (NodePath) var hat_node_path
export (NodePath) var robe_node_path
export (NodePath) var wand_node_path


func _ready():
	set_modulation(modulation)


func set_modulation(new_modulation):
	modulation = new_modulation
	get_node(hat_node_path).self_modulate = new_modulation
	get_node(robe_node_path).self_modulate = new_modulation
	if not Engine.editor_hint:
		get_node(wand_node_path).set_player_color(new_modulation)
