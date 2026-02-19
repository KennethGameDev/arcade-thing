extends DartsUI

var darts_game_ref: DartsGame
var reticle_segments: Array[ScalableVectorShape2D] = [$"Segment 1", $"Segment 2", $"Segment 3", $"Segment 4"]
var shrinking: bool = true


func _ready():
	darts_game_ref = get_tree().get_first_node_in_group("Game")


func _process(delta):
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
