extends Node3D

@export var ship: RigidBody3D
@export var force: float = 10.0
@export var activation_event: StringName


func _ready():
	ship.register_thruster(self)


var active := false
func _process(delta):
	if Input.is_action_pressed(activation_event):
		active = true
		
	else:
		active = false
