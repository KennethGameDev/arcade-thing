class_name MeanderCam
extends PlayerCamera

var mouse_sens: float = 0.003
var mouse_input: Vector2
var controller_sense: float = 0.03
var input_rotation: Vector3
var perspective: int = 1
var default_spring_length = 4
var target_pos: Vector3
var target_rot: Vector3


func _ready():
	pass


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() != 0:
		mouse_input.x += -event.relative.x * mouse_sens
		mouse_input.y += -event.relative.y * mouse_sens
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed and perspective != 0:
			# Trigger the shift the First Person
			perspective = 0 # Check handle_camera_view() for more detail
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed and perspective != 1:
			# Trigger the shift to Third Person
			perspective = 1 # Check handle_camera_view() for more detail


func process(delta):
	prints("Current Position:", GameManager.camera_ref.get_global_transform_interpolated().orthonormalized().origin)
	prints("Target Position:", target_pos)
	prints("Current Rotation:", GameManager.camera_ref.transform.basis.get_euler())
	prints("Target Rotation:", target_rot)
	if !get_is_camera_in_position(target_pos, target_rot):
		move_camera(target_pos, target_rot, delta)
	else:
		process_inputs()
		handle_inputs()
		handle_camera_view(delta)
		
		mouse_input = Vector2.ZERO


func process_inputs():
	var controller_look_input: Vector2 = Vector2(-Input.get_joy_axis(0, JOY_AXIS_RIGHT_X), -Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y))
	var controller_look_vector: Vector2 = controller_look_input
	var controller_dead_zone: float = 0.2
	
	if controller_look_vector.length() < controller_dead_zone:
		controller_look_vector = Vector2.ZERO
	else:
		controller_look_vector = controller_look_vector.normalized() * ((controller_look_vector.length() - controller_dead_zone) / (1 - controller_dead_zone))
	
	input_rotation.x = clampf(input_rotation.x + mouse_input.y + (controller_look_vector.y * 0.05), deg_to_rad(-80), deg_to_rad(75))
	input_rotation.y = mouse_input.x + (controller_look_vector.x * 0.05)


func handle_inputs():
	rotator.rotation.x = input_rotation.x
	rotator.rotate(Vector3.UP, input_rotation.y)
	GameManager.player_ref.mesh.rotate(Vector3.UP, input_rotation.y)


func handle_camera_view(delta: float):
	var camera_anchor_pos: Vector3 = GameManager.player_ref.cam_anchor.get_global_transform_interpolated().orthonormalized().origin
	var camera_pos_offset: float = 0
	
	# If Perspective is set to First Person (0):
	if perspective == 0:
		# Set the camera offset to 0.5
		camera_pos_offset = 0.5
		# Verify that the camera needs to zoom in.
		# If so: Lerp the spring arm's length to zero.
		if spring_arm.spring_length != 0:
			if spring_arm.spring_length < 0.001:
				spring_arm.spring_length = 0
			else:
				spring_arm.spring_length = lerpf(spring_arm.spring_length, 0, delta * 10)
	if perspective == 1:
		camera_pos_offset = 0.0
		# Verify that the camera needs to zoom out.
		# If so: Lerp the spring arm's length to the max.
		if spring_arm.spring_length != default_spring_length:
			if spring_arm.spring_length > default_spring_length - 0.001:
				spring_arm.spring_length = default_spring_length
			else:
				spring_arm.spring_length = lerpf(spring_arm.spring_length, default_spring_length, delta * 10)
	
	# Player becomes transparent if the camera is pushed too close to it.
	handle_camera_too_close()
	
	# Verify that the camera height needs to be adjusted.
	# If so: Shift the camera's position to the new position.
	if rotator.global_position != camera_anchor_pos - Vector3(0, camera_pos_offset, 0):
		rotator.global_position.x = camera_anchor_pos.x
		rotator.global_position.y = lerpf(rotator.global_position.y, camera_anchor_pos.y - camera_pos_offset, delta * 10)
		rotator.global_position.z = camera_anchor_pos.z
	# If not: Lock camera position to the new anchor position.
	else:
		rotator.global_position = camera_anchor_pos - Vector3(0, camera_pos_offset, 0)


func handle_camera_too_close():
	# Convenience variables:
	var cam_distance_to_player: float = camera.global_transform.origin.distance_to(GameManager.player_ref.cam_anchor.global_transform.origin)
	var trans_trigger_distance: float = 3.0
	var trans_trigger_min_distance: float = 2.4
	var trans_percent: float = (cam_distance_to_player - trans_trigger_min_distance) / (trans_trigger_distance - trans_trigger_min_distance)
	# If the camera is closer than the transition threshold:
	if cam_distance_to_player <= trans_trigger_distance:
		# Check if it's also closer than the minimum distance threshold.
		# If it is: Set the meshs' alpha levels to 0.
		if cam_distance_to_player <= trans_trigger_min_distance:
			GameManager.player_ref.mesh.material.albedo_color.a = 0
			GameManager.player_ref.mesh.get_child(0).material.albedo_color.a = 0
		# If it's not: Set the meshs' alpha to the calculated transition percent.
		else:
			GameManager.player_ref.mesh.material.albedo_color.a = trans_percent
			GameManager.player_ref.mesh.get_child(0).material.albedo_color.a = trans_percent
	# If the camera is further than the transition threshold: Set the meshs' alpha levels to 1.
	else:
		GameManager.player_ref.mesh.material.albedo_color.a = 1
		GameManager.player_ref.mesh.get_child(0).material.albedo_color.a = 1
