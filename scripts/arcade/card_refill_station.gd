extends Interactable


func _ready():
	self.category = "arcade services"
	camera_distance = 0.5


func initialize():
	GameManager.change_game_mode(GameManager.GameModes.CARD_REFILL_MODE, self)


func process(_delta):
	pass
