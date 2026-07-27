extends Control

var darts_game_ref: DartsGame
var shrinking: bool = true


func _ready():
	darts_game_ref = get_tree().get_first_node_in_group("Game")


func _process(delta):
	if darts_game_ref:
		position = darts_game_ref.mouse_position
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		rotation += delta
		if shrinking:
			scale = scale.move_toward(Vector2(0.5, 0.5), delta * 0.5)
			if scale <= Vector2(0.5, 0.5):
				shrinking = false
		else:
			scale = scale.move_toward(Vector2.ONE, delta * 0.5)
			if scale >= Vector2.ONE:
				shrinking = true
	else:
		rotation = 0
		scale = Vector2.ONE
		shrinking = true
