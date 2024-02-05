extends Control

@export var ship: RigidBody3D
@onready var speedometer = $speedometer
@onready var torqueometer = $torqueometer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


var line_dir := Vector2.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speedometer_text = "%sm/s" % str(ship.linear_velocity.length())
	var torqueometer_text = "%srad/s" % str(ship.angular_velocity.y)
	speedometer.text = speedometer_text
	torqueometer.text = torqueometer_text
	

func _input(event):
	line_dir = Vector2.ZERO
	if event is InputEventMouseMotion:
		if event.button_mask == 2:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			var normalized_direction = event.relative.normalized()
			line_dir = normalized_direction * 100
	queue_redraw()



func _draw():
	#print(line_dir)
	draw_line(get_viewport_rect().get_center(), get_viewport_rect().get_center()+line_dir, Color.GREEN, 1, true)
	pass
