class_name Arcade
extends Node3D


func _ready():
	GameManager.change_game_mode(GameManager.GameModes.MEANDER_MODE)


func _process(_delta):
	pass
