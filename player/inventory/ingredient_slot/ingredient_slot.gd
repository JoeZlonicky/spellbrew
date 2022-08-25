extends CenterContainer


export (String, "Empty", "Red", "Green", "Blue") var color = "Empty" setget set_color


func set_color(new_color):
	color = new_color
	for slot in get_children():
		slot.hide()
	get_node(new_color).show()
