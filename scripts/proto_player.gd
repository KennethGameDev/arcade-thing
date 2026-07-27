class_name Player
extends CharacterBody3D

@export var JUMP_VELOCITY: float = 4.5
@export var ACCELL: float = 0.11
@export var DECELL: float = 0.25
@export var SPEED: float = 5.0

var player_cam: CameraController

@export var cam_anchor: Marker3D
@onready var mesh: CSGMesh3D = $Mesh

@onready var interaction_range: Area3D = $Mesh/InteractionRange
var detected_interactables: Array[Interactable] = []
var current_interactable: Interactable

var control_mode: String


func _ready():
	pass


func _input(event):
	match control_mode:
		"meander":
			if event.is_action_pressed("jump"):
				handle_jump()
			if event.is_action_pressed("interact"):
				if current_interactable:
					current_interactable.interact()
				else:
					print("Nothing to interact with...")
		_:
			if event.is_action_pressed("escape") or event.is_action_pressed("interact"):
				GameManager.change_game_mode(GameManager.GameModes.MEANDER_MODE)
				GameManager.camera_ref.rotation = global_rotation


func _physics_process(delta):
	match control_mode:
		"meander":
			if GameManager.camera_ref.finished_cam_transition:
				# Add the gravity.
				if not is_on_floor():
					velocity += get_gravity() * delta
				
				#handle_run(delta)
				
				handle_locomotion()
		"card refill":
			velocity = Vector3.ZERO
			if current_interactable:
				#position.x = lerpf(position.x, current_interactable.player_position.global_position.x, delta)
				#position.z = lerpf(position.z, current_interactable.player_position.global_position.z, delta)
				position.x = current_interactable.player_position.global_position.x
				position.z = current_interactable.player_position.global_position.z
		"claw machine":
			pass
	move_and_slide()
	print(current_interactable)


func handle_locomotion():
	# Get the camera's direction
	var camera_transform_y: float = GameManager.camera_ref.handles.global_transform.basis.get_euler().y
	# Get the input direction and handle the movement/deceleration.
	var input: Vector2 = Input.get_vector("left", "right", "forward", "back")
	var input_dir: Vector3 = Vector3(input.x, 0, input.y)
	# Rotate the input direction around the UP axis by the camera's rotation
	var direction: Vector3 = input_dir.rotated(Vector3.UP, camera_transform_y).normalized()
	
	if direction:
		velocity = velocity.move_toward(direction * SPEED, ACCELL)
		#velocity = velocity.move_toward(direction * SPEED * run_speed_mult, ACCELL)
	else:
		velocity = velocity.move_toward(Vector3.ZERO, DECELL)


#func handle_run(delta: float):
	#if Input.is_action_pressed("run"):
		#button_timer += delta
		#if button_timer > button_hold_threshold:
			#button_held = true
	#
	#if run_level == 0:
		#if Input.is_action_just_pressed("run"):
			#change_run_level(1)
	#elif run_level == 1:
		#if Input.is_action_just_released("run"):
			#if button_timer < button_hold_threshold:
				#change_run_level(0)
		##if button_timer >= button_hold_threshold and button_held:
			##change_run_level(2)
	#
	#if Input.is_action_just_released("run"):
		#button_timer = 0
		#button_held = false
	#
	##if Focus.input_is_action_just_pressed(action):
		##if run_level == 0:
			##change_run_level(1)
		##elif run_level == 1:
			##change_run_level(0)
	##if button_timer > button_tap_threshold:
		##if run_level != 2:
			##change_run_level(2)
		##elif Focus.input_is_action_just_released(action):
			##change_run_level(prev_run_level)
	##if Focus.input_is_action_just_released(action):
		##button_timer = 0


func handle_jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


#region : Interaction-related functions
func set_closest_interactable():
	if control_mode == "meander":
		var closest_interactable: Interactable = null
		var current_interactable_distance: float = 999
		var prev_interactable_distance: float = 999
		
		if detected_interactables.size() != 0:
			for interactable in detected_interactables:
				prev_interactable_distance = current_interactable_distance
				current_interactable_distance = position.distance_to(interactable.position)
				if current_interactable_distance < prev_interactable_distance:
					closest_interactable = interactable
				else:
					interactable.hide_details()
		
		if closest_interactable != current_interactable:
			set_current_interactable(closest_interactable)


func set_current_interactable(interactable: Interactable):
	if control_mode == "meander":
		current_interactable = interactable
		current_interactable.show_details()


func _on_interaction_range_body_entered(body):
	if control_mode == "meander":
		detected_interactables.append(body)
		set_closest_interactable()


func _on_interaction_range_body_exited(body):
	if control_mode == "meander":
		var i: int = 0
		while i < detected_interactables.size():
			if detected_interactables[i] == body:
				var removed_interactable: Interactable = detected_interactables.pop_at(i)
				if removed_interactable == current_interactable:
					if detected_interactables.size() == 0:
						current_interactable.hide_details()
						current_interactable = null
					else:
						removed_interactable.hide_details()
						set_closest_interactable()
			i += 1
#endregion


func change_control_mode(new_mode: int):
	match new_mode:
		GameManager.GameModes.MEANDER_MODE:
			control_mode = "meander"
		GameManager.GameModes.CARD_REFILL_MODE:
			control_mode = "card refill"
		GameManager.GameModes.CLAW_MACHINE_MODE:
			control_mode = "claw machine"
