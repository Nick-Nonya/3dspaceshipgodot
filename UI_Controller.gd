extends Control

@export var ship: RigidBody3D
@onready var speedometer = $speedometer
@onready var torqueometer = $torqueometer

var draw_rotation_line := false
var line_endpoint := Vector2.ZERO
var viewport_center := Vector2.ZERO


func _ready():
	viewport_center = get_viewport_rect().get_center()
	pass


func _process(delta):
	var speedometer_text = "%sm/s" % str(ship.linear_velocity.length())
	var torqueometer_text = "%srad/s" % str(ship.angular_velocity.y)
	speedometer.text = speedometer_text
	torqueometer.text = torqueometer_text
	if Input.is_action_pressed("rotate_with_cursor"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		draw_rotation_line = true
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		draw_rotation_line = false
		line_endpoint = Vector2.ZERO

func _input(event):
	#line_dir = Vector2.ZERO
	#if event is InputEventMouseMotion:
		#if event.button_mask == 2:
			#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			#var normalized_direction = event.relative.normalized()
			#line_dir = normalized_direction * 100
	if event is InputEventMouseMotion:
		if event.button_mask == 2:
			line_endpoint += event.relative
			line_endpoint = line_endpoint.limit_length(100)
	queue_redraw()


func _draw():
	#print(line_dir)
	draw_line(viewport_center, viewport_center + line_endpoint, Color.GREEN, 1, true)
	
