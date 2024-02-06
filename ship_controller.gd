extends RigidBody3D


var input_direction := Vector3.ZERO
var input_rotation := Vector3.ZERO
var acceleration := 10.0
var should_speed_drag := false

var rotate_with_cursor := false
var cursor_vector := Vector2.ZERO

var thruster_list = []

func _ready():
	pass


func _process(delta):
	#print([cursor_vector, input_rotation])
	#input_direction = Input.get_vector("a","d","w","s")
	#input_direction.y = Input.get_axis("w","s")
	#input_direction.x = Input.get_axis("d","a")
	input_direction = Vector3( 
		Input.get_axis("left","right"), 
		Input.get_axis("down","up"), 
		Input.get_axis("forward","backward") 
		)
	
	
	if Input.is_action_pressed("rotate_with_cursor"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		rotate_with_cursor = true
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		rotate_with_cursor = false
		cursor_vector = Vector2.ZERO
		input_rotation = Vector3(
		Input.get_axis("pitch_down", "pitch_up"),
		Input.get_axis("yaw_right", "yaw_left"),
		Input.get_axis("roll_left", "roll_right")
	)
	
	if Input.is_action_just_pressed("toggle_speed_drag"):
		should_speed_drag = !should_speed_drag

func _input(event):
	if event is InputEventMouseMotion:
		if event.button_mask == 2:
			#var normalized_input_direction = event.relative.normalized()
			cursor_vector += event.relative
			cursor_vector = cursor_vector.normalized()
			#cursor_vector = cursor_vector.limit_length(100)
			#input_rotation.x = -normalized_input_direction.y
			#input_rotation.y = -normalized_input_direction.x
			input_rotation.x = -cursor_vector.y
			input_rotation.y = -cursor_vector.x

func _integrate_forces(state):
	#state.apply_force(Vector3(input_direction.x, 0.0, input_direction.y) * acceleration)
	#state.apply_force( transform.basis * Vector3( 0.0, input_direction.x, input_direction.y ) * acceleration )
	#state.apply_torque( Vector3( 0.0, input_rotation, 0.0 ) )
	
	#state.apply_force( transform.basis * input_direction * acceleration )
	
	for t: Node3D in thruster_list:
		if t.active:
			state.apply_force(transform.basis * -t.basis.z * t.force, transform.basis * t.position)
		
		
		
		
	state.apply_torque( transform.basis * input_rotation )
	if input_rotation.length() == 0:
		state.angular_velocity -= state.angular_velocity * 0.025
	if input_direction.length() == 0 and should_speed_drag:
		state.linear_velocity -= state.linear_velocity * 0.025
	
	if Input.is_action_just_pressed("brake"):
		state.linear_velocity = Vector3.ZERO
		state.angular_velocity = Vector3.ZERO
		#rotate_y(PI/2)

func register_thruster(thruster):
	thruster_list.append(thruster)
