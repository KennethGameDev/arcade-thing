extends ArcadeGame

@export var debug_message: String


func _ready():
	self.category = "prize game"
	arc_game_name = "Claw Machine Base"
	arc_game_type = "ClawMachine"
	play_cost = 12
	camera_distance = 0.5


func _process(_delta):
	pass


func _initialize_game():
	GameManager.change_game_mode(GameManager.GameModes.CLAW_MACHINE_MODE, self)


func _start_game():
	pass
