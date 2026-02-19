extends ArcadeGame

@export var debug_message: String
@onready var camera_anchor = $"Camera Anchor"


func _ready():
	self.category = "prize game"
	arc_game_name = "Claw Machine Base"
	arc_game_type = "ClawMachine"
	play_cost = 12


func _process(_delta):
	pass


func _initialize_game():
	print(debug_message)
	GameManager.change_game_mode(GameManager.GameModes.CLAW_MACHINE_MODE, self)


func _start_game():
	pass
