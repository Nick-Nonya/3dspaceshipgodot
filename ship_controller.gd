extends RigidBody3D

var direction := Vector3.ZERO
var input_rotation := Vector3.ZERO
var acceleration := 10.0

func _ready():
	pass


func _process(delta):
	#direction = Input.get_vector("a","d","w","s")
	#direction.y = Input.get_axis("w","s")
	#direction.x = Input.get_axis("d","a")
	direction = Vector3( 
		Input.get_axis("left","right"), 
		Input.get_axis("down","up"), 
		Input.get_axis("forward","backward") 
		)
	input_rotation = Vector3(
		Input.get_axis("pitch_down", "pitch_up"),
		Input.get_axis("yaw_left", "yaw_right"),
		Input.get_axis("roll_left", "roll_right")
	)
	
func _integrate_forces(state):
	#state.apply_force(Vector3(direction.x, 0.0, direction.y) * acceleration)
	#state.apply_force( transform.basis * Vector3( 0.0, direction.x, direction.y ) * acceleration )
	#state.apply_torque( Vector3( 0.0, input_rotation, 0.0 ) )
	state.apply_force( transform.basis * direction * acceleration )
	state.apply_torque( transform.basis * input_rotation )
	if input_rotation.length() == 0:
		state.angular_velocity -= state.angular_velocity * 0.025
	
	if Input.is_action_just_pressed("brake"):
		state.linear_velocity = Vector3.ZERO
		state.angular_velocity = Vector3.ZERO
