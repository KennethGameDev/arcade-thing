class_name CameraController
extends Node3D

@export var handles: Node3D
@export var spring_arm: SpringArm3D
@export var camera: Camera3D
@export var camera_modes: Dictionary[String, CameraController]
var current_cam_mode: String
var current_cam_anchor_pos: Vector3
var current_cam_anchor_trans: Transform3D


func _ready():
	GameManager.camera_ref = self
	position = GameManager.player_ref.cam_anchor.get_global_transform_interpolated().orthonormalized().origin
	rotation = GameManager.player_ref.global_rotation
	initialize_camera_modes()


func _process(delta):
	if handles.global_position.distance_to(current_cam_anchor_pos) > 0.05:
		move_camera(current_cam_anchor_trans, delta)
	else:
		if current_cam_mode == "Meander Mode":
			current_cam_anchor_pos = GameManager.player_ref.cam_anchor.get_global_transform_interpolated().orthonormalized().origin
		camera_modes[current_cam_mode].process(delta)


func initialize_camera_modes():
	for mode in camera_modes:
		camera_modes[mode].handles = handles
		camera_modes[mode].spring_arm = spring_arm
		camera_modes[mode].camera = camera
		camera_modes[mode].camera_modes = camera_modes
		camera_modes[mode].current_cam_mode = current_cam_mode
		camera_modes[mode].current_cam_anchor_pos = current_cam_anchor_pos
		camera_modes[mode].current_cam_anchor_trans = current_cam_anchor_trans


func change_camera_mode(new_mode: int, new_cam_anchor: Marker3D):
	current_cam_anchor_pos = new_cam_anchor.get_global_transform_interpolated().orthonormalized().origin
	current_cam_anchor_trans = new_cam_anchor.get_global_transform_interpolated()
	print(current_cam_anchor_trans)
	match new_mode:
		GameManager.GameModes.MEANDER_MODE:
			current_cam_mode = "Meander Mode"
		GameManager.GameModes.CLAW_MACHINE_MODE:
			current_cam_mode = "Claw Machine Mode"
	initialize_camera_modes()


func move_camera(target_transform: Transform3D, delta: float):
	handles.global_transform = handles.global_transform.interpolate_with(target_transform, delta)
	#handles.global_position = handles.global_position.move_toward(target_pos, delta)
	#handles.rotation.x = lerpf(handles.rotation.x, 0, delta)
	#handles.rotation.y = lerpf(handles.rotation.y, 0, delta)
