class_name DartsUI
extends Control

@onready var ui_reticle_controller: Control = $DartsReticleController
@onready var ui_dart_customizer: Control = $DartCustomizer
@onready var ui_game_rules_selector: Control = $DartsGameRulesSelector
@onready var dart_preview_lighting: DirectionalLight3D = $DirectionalLight3D


func _ready():
	var i: int = 1
	while i < get_children().size():
		if get_child(i).visible:
			get_child(i).visible = false
		if get_child(i).name == ui_game_rules_selector.name:
			_set_ui_element_visiblity(ui_game_rules_selector, true)
		i += 1


func _process(_delta):
	pass


func _set_ui_element_visiblity(ui_element: Control, new_visiblity: bool):
	ui_element.visible = new_visiblity


func _toggle_ui_element_visibility(ui_element: Control):
	ui_element.visible = !ui_element.visible
