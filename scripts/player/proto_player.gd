class_name Player
extends CharacterBody3D


@export var JUMP_VELOCITY: float = 4.5
@export var ACCELL: float = 0.11
@export var DECELL: float = 0.25
@export var SPEED: float = 5.0
var direction: Vector3 = Vector3.ZERO

var player_cam: CameraController

@export var cam_anchor: Marker3D
@onready var mesh: CSGMesh3D = $Mesh

enum STATE {
	IDLE = 0,
	WALK = 1,
	RUN = 2,
	JUMP = 3,
	FALL = 4,
	GAMING = 5,
	SOCALIZING = 6
}

var peer_id: int = 1 # The peer that controls this player
var local = true # If this player belongs to the local peer

var state: STATE = STATE.IDLE: # The current state the player is in
	set(value):
		# Limit the value to the bounds of STATE
		state = clampi(value, 0, STATE.size() - 1) as STATE
		# Change animation based on state:
		# [[WIP]]


func _enter_tree() -> void:
	# Set node authority
	peer_id = int(name)
	%ClientSynchronizer.set_multiplayer_authority(peer_id)
	local = (peer_id == multiplayer.get_unique_id())


func _ready() -> void:
	if local:
		# Activate the camera if local
		%Camera3D.make_current()


func _input(event) -> void:
	if event.is_action_pressed("jump") and is_on_floor():
		jump()


func _physics_process(delta) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	handle_locomotion()

	match(state):
		STATE.IDLE: _state_idle(direction, delta)
		STATE.WALK: _state_walk(direction, delta)
		STATE.RUN: _state_run(direction, delta)
		STATE.JUMP: _state_jump(direction, delta)
		STATE.FALL: _state_fall(direction, delta)
		STATE.GAMING: _state_gaming(direction, delta)
		STATE.SOCALIZING: _state_socializing(direction, delta)

	move_and_slide()


#region: Internal Helpers

func _check_jump() -> bool:
	if is_on_floor() and is_zero_approx(velocity.y):
		jump()
		return true
	return false


func _check_fall() -> bool:
	if !is_on_floor() and velocity.y > 0.0:
		state = STATE.FALL
		return true
	return false


func _check_walk() -> bool:
	if !is_zero_approx(velocity.x) or !is_zero_approx(velocity.z):
		state = STATE.WALK
		return true
	return false


func _check_idle() -> bool:
	if is_zero_approx(velocity.x) and is_zero_approx(velocity.z):
		state = STATE.IDLE
		return true
	return false

#endregion


#region: Public Helpers

func handle_locomotion() -> void:
	# Get the camera's direction
	var camera_transform_y: float = %Camera3D.global_transform.basis.get_euler().y
	# Get the input direction and handle the movement/deceleration.
	var input: Vector2 = Input.get_vector("left", "right", "forward", "back")
	var input_dir: Vector3 = Vector3(input.x, 0, input.y)
	# Rotate the input direction around the UP axis by the camera's rotation
	direction = input_dir.rotated(Vector3.UP, camera_transform_y).normalized()
	
	if direction:
		velocity = velocity.move_toward(direction * SPEED, ACCELL)
	else:
		velocity = velocity.move_toward(Vector3.ZERO, DECELL)


func get_direction() -> Vector3:
	return direction


func jump() -> void:
	if state == STATE.JUMP: return
	state = STATE.JUMP
	velocity.y = JUMP_VELOCITY

#endregion


#region: States

func _state_idle(_direction: Vector3, _delta: float) -> void:
	if _check_fall(): return
	if _check_walk(): return
	if _check_jump(): return


func _state_walk(_direction: Vector3, _delta: float) -> void:
	pass


func _state_run(_direction: Vector3, _delta: float) -> void:
	pass


func _state_jump(_direction: Vector3, _delta: float) -> void:
	pass


func _state_fall(_direction: Vector3, _delta: float) -> void:
	pass


func _state_gaming(_direction: Vector3, _delta: float) -> void:
	pass


func _state_socializing(_direction: Vector3, _delta: float) -> void:
	pass

#endregion


#region: RPC Functions

@rpc("authority", "call_local", "reliable")
func teleport(new_pos: Vector3) -> void:
	velocity = Vector3.ZERO
	global_position = new_pos
	state = STATE.IDLE

#endregion