extends Node


var players: Array[Player]
var player_cam_anchor_transforms: Dictionary[Player, Transform3D]


func _ready():
	pass


func _process(_delta):
	# If there are players in the game,
	if players.size() != 0:
		# for each player:
		for player in players:
			# check if their camera anchors positions already have an entry.
			# If it does:
			if player_cam_anchor_transforms.has(player):
				# update the position.
				player_cam_anchor_transforms.set(player, player.cam_anchor.get_global_transform_interpolated())
			# If it doesn't:
			else:
				# create an entry.
				player_cam_anchor_transforms.get_or_add(player, player.cam_anchor.get_global_transform_interpolated())
