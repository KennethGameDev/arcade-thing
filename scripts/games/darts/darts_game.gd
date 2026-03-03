class_name DartsGame
extends ArcadeGame

# TODO: Make this controller-compatible
var mouse_sense: float = 0.25
var mouse_sense_modifier: float = 1
var mouse_position: Vector2
var mouse_button_pressed: bool = true
var p1_darts: Array[Dart]
var p2_darts: Array[Dart]

@export var debug_message: String


func _initialize_game():
	pass


func _ready():
	mouse_position.x = GameManager.right_limit / 2
	mouse_position.y = GameManager.lower_limit / 2


func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		mouse_position.x += event.relative.x * mouse_sense * mouse_sense_modifier
		mouse_position.y += event.relative.y * mouse_sense * mouse_sense_modifier
	
	if event is InputEventMouseButton:
		# The code in the if statement will only run when the left mouse button is released.
		if !mouse_button_pressed:
			_throw_dart()
		mouse_button_pressed = !mouse_button_pressed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		mouse_sense_modifier = 0.3
	else:
		mouse_sense_modifier = 1
	
	if mouse_position.x < GameManager.left_limit:
		mouse_position.x = GameManager.left_limit
	if mouse_position.x > GameManager.right_limit:
		mouse_position.x = GameManager.right_limit
	if mouse_position.y < GameManager.upper_limit:
		mouse_position.y = GameManager.upper_limit
	if mouse_position.y > GameManager.lower_limit:
		mouse_position.y = GameManager.lower_limit


func _throw_dart():
	print("Throw dart code goes here")
	
