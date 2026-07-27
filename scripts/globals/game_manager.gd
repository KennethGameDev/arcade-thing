extends Node

#var all_interactables: Dictionary[String, Dictionary] = {
	#"prize games": {},
	#"lottery games": {},
	#"ranked games": {},
	#"booths": {}
#}
var current_game_name: String

var current_ui: Control
var screen_size: Rect2
var left_limit: float
var right_limit: float
var upper_limit: float
var lower_limit: float

var player_start: PlayerStart
@onready var player_scene = preload("uid://pb213jsy1a7f")
@onready var player_ref: Player = player_scene.instantiate()
@onready var camera_scene = preload("uid://drceaq1lxg5k6")
@onready var camera_ref: CameraController = camera_scene.instantiate()
enum GameModes {MEANDER_MODE, CARD_REFILL_MODE, CLAW_MACHINE_MODE}


func _ready():
	get_tree().root.add_child.call_deferred(player_ref)
	get_tree().root.add_child.call_deferred(camera_ref)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(_delta):
	pass


func spawn_player():
	player_start = get_tree().get_first_node_in_group("Player Start")
	player_ref.position = player_start.position
	player_ref.rotation = player_start.rotation


func change_game_mode(new_mode: int, interactable_activated: Interactable = null):
	var current_interactable: Interactable = interactable_activated
	player_ref.change_control_mode(new_mode)
	if current_interactable:
		camera_ref.change_camera_mode(new_mode, current_interactable.camera_anchor)
	else:
		if new_mode == 0: camera_ref.change_camera_mode(new_mode, player_ref.cam_anchor)
