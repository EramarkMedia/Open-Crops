extends Camera

const drag_modifiyer = 0.005
const translate_modifiyer = 0.001
var is_dragging = false
var is_translating = false
export(NodePath) var slider

# warning-ignore:unused_argument
func _process(delta):
	pass
	if (is_translating):
		translate_object_local(Vector3(0,0,-1) * translate_modifiyer * get_node(slider).value)

func _input(event):
	if (event is InputEventMouseMotion):
		if (is_dragging):
			rotate_y(event.relative.x * drag_modifiyer)
			rotate_object_local(Vector3(1,0,0), event.relative.y * drag_modifiyer)
	elif (event is InputEventMouseButton):
		if (event.button_index == BUTTON_RIGHT):
			is_dragging = event.pressed
		if (event.button_index == BUTTON_LEFT):
			is_translating = event.pressed
	else:
		print(event)
