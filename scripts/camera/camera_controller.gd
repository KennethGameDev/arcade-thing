class_name CameraController
extends Node3D

@export var handles: Node3D
@export var spring_arm: SpringArm3D
@export var camera: Camera3D
@export var camera_modes: Dictionary[String, CameraController]
var current_cam_mode: String
var current_cam_anchor_trans: Transform3D
var finished_cam_transition: bool


func _ready():
	# position = GameManager.player_ref.cam_anchor.get_global_transform_interpolated().orthonormalized().origin
	# rotation = GameManager.player_ref.global_rotation
	initialize_camera_modes()


func _process(delta):
	if current_cam_mode == "Meander Mode":
		current_cam_anchor_trans = camera_modes[current_cam_mode].camera_anchor_offset_transform
	# move_camera(current_cam_anchor_trans, delta)


func initialize_camera_modes():
	for mode in camera_modes:
		camera_modes[mode].handles = handles
		camera_modes[mode].spring_arm = spring_arm
		camera_modes[mode].camera = camera
		camera_modes[mode].camera_modes = camera_modes
		camera_modes[mode].current_cam_mode = current_cam_mode
		camera_modes[mode].current_cam_anchor_trans = current_cam_anchor_trans
		camera_modes[mode].finished_cam_transition = finished_cam_transition


func change_camera_mode(new_mode: int, new_cam_anchor: Marker3D):
	finished_cam_transition = false
	current_cam_anchor_trans = new_cam_anchor.get_global_transform_interpolated()
	
	# match new_mode:
	# 	GameManager.GameModes.MEANDER_MODE:
	# 		current_cam_mode = "Meander Mode"
	# 	GameManager.GameModes.CARD_REFILL_MODE:
	# 		current_cam_mode = "Card Refill Mode"
	# 	GameManager.GameModes.CLAW_MACHINE_MODE:
	# 		current_cam_mode = "Claw Machine Mode"
	initialize_camera_modes()


# func move_camera(target_transform: Transform3D, delta: float):
# 	if handles.global_position.distance_to(current_cam_anchor_trans.origin) > 0.005 and !finished_cam_transition:
# 		if current_cam_mode == "Meander Mode":
# 			handles.global_transform = handles.global_transform.interpolate_with(target_transform, delta * 3)
# 			spring_arm.spring_length = lerpf(spring_arm.spring_length, camera_modes["Meander Mode"].current_spring_length, delta * 3)
# 		else:
# 			handles.global_transform = handles.global_transform.interpolate_with(target_transform, delta * 1.5)
# 			spring_arm.spring_length = lerpf(spring_arm.spring_length, GameManager.player_ref.current_interactable.camera_distance, delta * 1.5)
# 	else:
# 		if !finished_cam_transition:
# 			finished_cam_transition = true
# 			handles.global_transform = target_transform
# 			if current_cam_mode == "Meander Mode":
# 				spring_arm.spring_length = camera_modes["Meander Mode"].current_spring_length
# 			else:
# 				spring_arm.spring_length = GameManager.player_ref.current_interactable.camera_distance
# 		camera_modes[current_cam_mode].process(delta)
