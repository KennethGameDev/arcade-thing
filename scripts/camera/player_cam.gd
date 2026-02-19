class_name PlayerCamera
extends Node3D

@onready var rotator = $Rotator
@onready var spring_arm = $Rotator/SpringArm3D
@onready var camera = $Rotator/SpringArm3D/Camera3D
@onready var camera_modes: Dictionary = {
	"Meander Mode": $"Meander Mode",
	"Claw Machine Mode": $"Claw Machine Mode",
	}
var current_cam_mode: String


func _ready():
	GameManager.camera_ref = self
	position = GameManager.player_ref.cam_anchor.get_global_transform_interpolated().orthonormalized().origin
	rotation = GameManager.player_ref.global_rotation
	initialize_camera_modes()


func _process(delta):
	match current_cam_mode:
		"meander":
			camera_modes["Meander Mode"].process(delta)
		"claw machine":
			camera_modes["Claw Machine Mode"].process(delta)


func initialize_camera_modes():
	for key in camera_modes:
		camera_modes[key].rotator = rotator
		camera_modes[key].spring_arm = spring_arm
		camera_modes[key].camera = camera


func change_camera_mode(new_mode: int):
	match new_mode:
		GameManager.GameModes.MEANDER_MODE:
			camera_modes["Meander Mode"].target_pos = GameManager.player_ref.cam_anchor.get_global_transform_interpolated().orthonormalized().origin
			camera_modes["Meander Mode"].target_rot = GameManager.player_ref.global_rotation
			current_cam_mode = "meander"
		GameManager.GameModes.CLAW_MACHINE_MODE:
			camera_modes["Claw Machine Mode"].target_pos = GameManager.current_game.camera_anchor.get_global_transform_interpolated().orthonormalized().origin
			camera_modes["Claw Machine Mode"].target_rot = GameManager.current_game.camera_anchor.transform.basis.get_euler()
			current_cam_mode = "claw machine"


func move_camera(target_pos: Vector3, target_rot: Vector3, delta: float):
	global_position.move_toward(target_pos, delta)
	rotation.move_toward(target_rot, delta)


func get_is_camera_in_position(target_pos: Vector3, target_rot: Vector3) -> bool:
	var current_pos: Vector3 = GameManager.camera_ref.global_position
	var current_rot: Vector3 = GameManager.camera_ref.rotator.transform.basis.get_euler()
	
	var pos_pass: bool = false
	var rot_pass: bool = false
	
	if current_pos.distance_to(target_pos) < 0.05:
		pos_pass = true
	if current_rot.distance_to(target_rot) < 0.05:
		rot_pass = true
	
	if pos_pass and rot_pass:
		return true
	else: return false
