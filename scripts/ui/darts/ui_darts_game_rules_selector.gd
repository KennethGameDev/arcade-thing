extends DartsUI


@onready var continue_button = $OuterMargins/HBoxContainer/RuleSelector/MarginContainer/VBoxContainer/ContinueButton


func _ready():
	pass


func _process(_delta):
	pass


func _on_continue_button_pressed():
	_set_ui_element_visiblity(self, false)
	_set_ui_element_visiblity(GameManager.current_ui.ui_dart_customizer, true)
