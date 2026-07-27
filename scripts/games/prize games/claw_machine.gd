extends PrizeGame


func _ready():
	self.category = "prize game"
	game_name = "Claw Machine Prototype"
	game_type = "ClawMachine"
	play_cost = 12
	camera_distance = 0.5


func process(_delta):
	pass


func initialize():
	GameManager.change_game_mode(GameManager.GameModes.CARD_REFILL_MODE, self)


func start_game():
	pass
