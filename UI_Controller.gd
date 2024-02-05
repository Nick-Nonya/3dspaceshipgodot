extends Control

@export var ship: RigidBody3D
@onready var speedometer = $speedometer
@onready var torqueometer = $torqueometer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speedometer_text = "%sm/s" % str(ship.linear_velocity.length())
	var torqueometer_text = "%srad/s" % str(ship.angular_velocity.y)
	speedometer.text = speedometer_text
	torqueometer.text = torqueometer_text

