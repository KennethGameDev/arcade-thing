extends Node


# Arrays containing references to every game in the arcade
var prize_games: Array[PrizeGame]
var ranked_games: Array[RankedGame]
var lottery_games: Array[LotteryGame]

# Dictionaries containing all the aracde games' anchor positions as global transforms
var game_cam_anchor_transforms: Dictionary[ArcadeGame, Transform3D]
var player_pos_anchor_transforms: Dictionary[ArcadeGame, Transform3D]

# A dictionary containing all the arcade games' leaderboards
var ranked_games_leaderboards: Dictionary[RankedGame, Leaderboard]
# A master leaderboard that adds up the total points for every player, compiled into one big leaderboard.
var master_leaderboard: Leaderboard


func _ready():
	pass


func _process(_delta):
	pass
