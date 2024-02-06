extends Node3D

var is_rotating = false
var initial_click_pos = Vector2.ZERO

func _process(delta):
	if is_rotating:
		var current_mouse_pos = get_viewport().get_mouse_position()
		var delta_pos = current_mouse_pos - initial_click_pos
		rotate_object(delta_pos)
		initial_click_pos = current_mouse_pos



func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			is_rotating = true
			initial_click_pos = event.global_position
		else:
			is_rotating = false

func rotate_object(delta_pos):
	var sensitivity = 0.01

	var local_right = transform.basis.x
	var local_up = transform.basis.y

	rotate(local_right, -delta_pos.y * sensitivity)
	rotate(local_up, -delta_pos.x * sensitivity)
