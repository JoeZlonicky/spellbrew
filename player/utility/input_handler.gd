extends Node


export (String, "kbm", "0", "1", "2", "3", "4") var device_name = "kbm"

var movement_inputs = {"move_up": false, "move_right": false, "move_down": false, "move_left": false}
var interact_pressed = false
var cast_pressed = false


func _input(event) -> void:
	if device_name != _get_event_device_name(event):
		return
	
	if event.is_action_pressed("interact"):
		interact_pressed = true
	elif event.is_action_released("interact"):
		interact_pressed = false
	elif event.is_action_pressed("cast"):
		cast_pressed = true
	elif event.is_action_released("cast"):
		cast_pressed = false
	
	for movement_event in movement_inputs.keys():
		if event.is_action_pressed(movement_event):
			movement_inputs[movement_event] = true
		elif event.is_action_released(movement_event):
			movement_inputs[movement_event] = false


func _get_event_device_name(event) -> String:
	if event is InputEventKey or event is InputEventMouse:
		return "kbm"
	elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
		return str(event.device)
	return ""


func get_movement_input_vector() -> Vector2:
	var movement := Vector2.ZERO
	
	if movement_inputs["move_right"]:
		movement.x += 1
	if movement_inputs["move_left"]:
		movement.x -= 1
	if movement_inputs["move_up"]:
		movement.y -= 1
	if movement_inputs["move_down"]:
		movement.y += 1
	
	return movement


func is_kbm() -> bool:
	return device_name == "kbm"
