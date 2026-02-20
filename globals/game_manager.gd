extends Node

#var all_interactables: Dictionary[String, Dictionary] = {
	#"prize games": {},
	#"lottery games": {},
	#"ranked games": {},
	#"booths": {}
#}
var current_interactable: Interactable
var current_game_name: String

var current_ui: Control
var screen_size: Rect2
var left_limit: float
var right_limit: float
var upper_limit: float
var lower_limit: float

var player_ref: Player
var camera_ref: CameraController
enum GameModes {MEANDER_MODE, CLAW_MACHINE_MODE}


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(_delta):
	pass


func change_game_mode(new_mode: int, new_interactable: Interactable = null):
	current_interactable = new_interactable
	player_ref.change_control_mode(new_mode)
	if current_interactable:
		camera_ref.change_camera_mode(new_mode, current_interactable.camera_anchor)
	else:
		camera_ref.change_camera_mode(new_mode, player_ref.cam_anchor)
