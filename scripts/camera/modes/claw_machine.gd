class_name ClawGameCam
extends PlayerCamera

var target_pos: Vector3
var target_rot: Vector3

func _ready():
	pass


func process(delta):
	if GameManager.current_game:
		prints("Current Position:", GameManager.camera_ref.get_global_transform_interpolated().orthonormalized().origin)
		prints("Target Position:", target_pos)
		prints("Current Rotation:", GameManager.camera_ref.transform.basis.get_euler())
		prints("Target Rotation:", target_rot)
		if !GameManager.camera_ref.get_is_camera_in_position(target_pos, target_rot):
			GameManager.camera_ref.move_camera(target_pos, target_rot, delta)
	else:
		print("Game not valid")
