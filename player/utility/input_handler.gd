extends Node


export (String, "kbm", "0", "1", "2", "3", "4") var device_name = "kbm"

var movement_inputs = {"move_up": 0.0, "move_right": 0.0, "move_down": 0.0, "move_left": 0.0}
var interact_pressed = false
var cast_pressed = false


func _input(event: InputEvent) -> void:
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
	
	if not is_kbm(): return
	
	for movement_event in movement_inputs.keys():
		if event.is_action_pressed(movement_event):
			movement_inputs[movement_event] = 1.0
		elif event.is_action_released(movement_event):
			movement_inputs[movement_event] = 0.0


func _physics_process(_delta: float) -> void:
	if is_kbm(): return
	
	var h_axis = Input.get_joy_axis(int(device_name), JOY_AXIS_0)
	var v_axis = Input.get_joy_axis(int(device_name), JOY_AXIS_1)
	
	movement_inputs["move_up"] = abs(v_axis) if v_axis < -0.1 else 0.0
	movement_inputs["move_down"] = v_axis if v_axis > 0.1 else 0.0
	movement_inputs["move_right"] = h_axis if h_axis > 0.1 else 0.0
	movement_inputs["move_left"] = abs(h_axis) if h_axis < -0.1 else 0.0


func _get_event_device_name(event: InputEvent) -> String:
	if event is InputEventKey or event is InputEventMouse:
		return "kbm"
	elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
		return str(event.device)
	return ""


func get_movement_input_vector() -> Vector2:
	var movement := Vector2.ZERO
	movement.x += movement_inputs["move_right"]
	movement.x -= movement_inputs["move_left"]
	movement.y -= movement_inputs["move_up"]
	movement.y += movement_inputs["move_down"]
	
	return movement


func is_kbm() -> bool:
	return device_name == "kbm"


func get_right_stick_vector() -> Vector2:
	if is_kbm(): return Vector2.ZERO
	
	return Vector2(Input.get_joy_axis(int(device_name), JOY_AXIS_2),
		Input.get_joy_axis(int(device_name), JOY_AXIS_3))
	
