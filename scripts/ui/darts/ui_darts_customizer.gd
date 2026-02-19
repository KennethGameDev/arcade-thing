extends DartsUI

@onready var players: Dictionary[int, Dictionary] = {
	1: {"Menu Lines": [
			null,
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_1, # Team Color
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_2, # Customizer Header
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_3, # Same Flight Colors
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_4, # Main Flight Color
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_5, # Secondary Flight Color
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_6, # Shaft Color
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_7, # Barrel Color
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_8, # Tip Color
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_9  # Reset and Ready Buttons
		],
		"Label Refs": [
			null,
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_1/Label, # Team Color
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_2/Label, # Customizer Header
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_3/Label, # Same Flight Colors
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_4/Label, # Main Flight Color
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_5/Label, # Secondary Flight Color
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_6/Label, # Shaft Color
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_7/Label, # Barrel Color
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_8/Label, # Tip Color
			null
		],
		"Button Refs": [
			null, # No Button
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_1/OptionButton, # Team Color Options Button
			null, # Not Button
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_3/CheckBox, # Same Flight Colors Checkbox
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_4/ColorPickerButton, # Main Flight Color Picker
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_5/ColorPickerButton, # Sec. Flight Color Picker
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_6/ColorPickerButton, # Shaft Color Picker
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_7/ColorPickerButton, # Barrel Color Picker
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_8/ColorPickerButton, # Tip Color Picker
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_9/ResetButton, # Reset Button
			$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_9/DoneButton # Done Button
		]
	},
}

#region : Player 1 Variables
@onready var p1_dart: Dart = $"OuterMargins/Panel/InnerMargins/HBoxContainer/Panel/Player 1 Dart SubViewport/dart"

# An array of every option line in the menu.
# Index '0' contains 'null' so the indicies align with the in-game line numbers.
@onready var p1_option_lines: Array[HBoxContainer] = [
	null,
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_1,
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_2,
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_3,
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_4,
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_5,
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_6,
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_7,
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_8,
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_9
]

# An array of every option label in the menu.
# '0' contains 'null' again to align the indicies with the option lines array.
# Any line that has no label will also contain 'null'.
@onready var p1_label_refs: Array[Label] = [
	null,
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_1/Label, # Team Color
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_2/Label, # Customizer Header
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_3/Label, # Same Flight Colors
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_4/Label, # Main Flight Color
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_5/Label, # Secondary Flight Color
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_6/Label, # Shaft Color
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_7/Label, # Barrel Color
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_8/Label, # Tip Color
	null
]

# An array of every button in the menu.
# As above, the indicies are aligned with the option lines array, with the
# exception of the last two indicies; 9 and 10, and 'null' means no button.
# Index 9 is the first button on line 9, and 10 is the second button on line 9.
@onready var p1_button_refs: Array[Button] = [
	null, # No Button
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_1/OptionButton, # Team Color Options Button
	null, # Not Button
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_3/CheckBox, # Same Flight Colors Checkbox
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_4/ColorPickerButton, # Main Flight Color Picker
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_5/ColorPickerButton, # Sec. Flight Color Picker
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_6/ColorPickerButton, # Shaft Color Picker
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_7/ColorPickerButton, # Barrel Color Picker
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_8/ColorPickerButton, # Tip Color Picker
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_9/ResetButton, # Reset Button
	$OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line_9/DoneButton # Done Button
]
var p1_line_states: Array = [null, 1, 1, 1, 1, 1, 1, 1, 1, 1]
var p1_default_dart_colors: Dictionary[String, Color] = {
	"flight main": Color(),
	"flight secondary": Color(),
	"shaft": Color(),
	"barrel": Color(),
	"tip": Color()
}
var p1_custom_dart_colors: Dictionary[String, Color] = {
	"flight main": Color(),
	"flight secondary": Color(),
	"shaft": Color(),
	"barrel": Color(),
	"tip": Color()
}

#@onready var p1_team_select: OptionButton = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line1/OptionButton
#@onready var p1_same_flight_colors: CheckBox = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line3/CheckBox
#@onready var p1_flight_main_color_picker: ColorPickerButton = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line4/ColorPickerButton
#@onready var p1_flight_secondary_color_picker: ColorPickerButton = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line5/ColorPickerButton
#@onready var p1_shaft_color_picker: ColorPickerButton = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line6/ColorPickerButton
#@onready var p1_barrel_color_picker: ColorPickerButton = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line7/ColorPickerButton
#@onready var p1_tip_color_picker: ColorPickerButton = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line8/ColorPickerButton
#@onready var p1_team_select_label: Label = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line1/Label
#@onready var p1_custom_section_label = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line2/Label
#@onready var p1_same_flight_colors_label: Label = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line3/Label
#@onready var p1_flight_color_main_label: Label = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line4/Label
#@onready var p1_flight_color_secondary_label: Label = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line5/Label
#@onready var p1_shaft_color_label = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line6/Label
#@onready var p1_barrel_color_label = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line7/Label
#@onready var p1_tip_color_label = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line8/Label
#@onready var p1_ready_button: Button = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer/Line9/Button


#@onready var p1_all_menu_option_refs: Array = [
	#p1_team_select, 
	#p1_same_flight_colors,
	#p1_flight_main_color_picker,
	#p1_flight_secondary_color_picker,
	#p1_shaft_color_picker,
	#p1_barrel_color_picker,
	#p1_tip_color_picker
#]
#@onready var p1_all_menu_option_labels: Array[Label] = [
	#p1_team_select_label,
	#p1_custom_section_label,
	#p1_same_flight_colors_label,
	#p1_flight_color_main_label,
	#p1_flight_color_secondary_label,
	#p1_shaft_color_label,
	#p1_barrel_color_label,
	#p1_tip_color_label
#]
var p1_prev_option_line_enabled_states: Array[bool] = [0, 0, 0, 0, 0, 0, 0]
var p1_custom_flight_main_color: Color
var p1_custom_flight_secondary_color: Color
var p1_ready: bool = false
#endregion

#region : Player 2 Variables
@onready var p2_dart: Dart = $"OuterMargins/Panel/InnerMargins/HBoxContainer/Panel2/Player 2 Dart SubViewport/dart"
@onready var p2_team_select: OptionButton = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer2/Line1/OptionButton
@onready var p2_same_flight_colors: CheckBox = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer2/Line3/CheckBox
@onready var p2_flight_main_color_picker: ColorPickerButton = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer2/Line4/ColorPickerButton
@onready var p2_flight_secondary_color_picker: ColorPickerButton = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer2/Line5/ColorPickerButton
@onready var p2_shaft_color_picker: ColorPickerButton = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer2/Line6/ColorPickerButton
@onready var p2_barrel_color_picker: ColorPickerButton = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer2/Line7/ColorPickerButton
@onready var p2_tip_color_picker: ColorPickerButton = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer2/Line8/ColorPickerButton
@onready var p2_team_select_label = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer2/Line1/Label
@onready var p2_custom_section_label = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer2/Line2/Label
@onready var p2_same_flight_colors_label = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer2/Line3/Label
@onready var p2_flight_color_main_label: Label = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer2/Line4/Label
@onready var p2_flight_color_secondary_label: Label = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer2/Line5/Label
@onready var p2_shaft_color_label = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer2/Line6/Label
@onready var p2_barrel_color_label = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer2/Line7/Label
@onready var p2_tip_color_label = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer2/Line8/Label
@onready var p2_ready_button: Button = $OuterMargins/Panel/InnerMargins/HBoxContainer/VBoxContainer2/Line9/Button
@onready var p2_all_menu_option_refs: Array = [
	p2_team_select, 
	p2_same_flight_colors,
	p2_flight_main_color_picker,
	p2_flight_secondary_color_picker,
	p2_shaft_color_picker,
	p2_barrel_color_picker,
	p2_tip_color_picker
]
@onready var p2_all_menu_option_labels: Array[Label] = [
	p2_team_select_label,
	p2_custom_section_label,
	p2_same_flight_colors_label,
	p2_flight_color_main_label,
	p2_flight_color_secondary_label,
	p2_shaft_color_label,
	p2_barrel_color_label,
	p2_tip_color_label
]
var p2_prev_menu_item_states: Array[bool] = [0, 0, 0, 0, 0, 0, 0]
var p2_custom_flight_main_color: Color
var p2_custom_flight_secondary_color: Color
var p2_ready: bool = false
#endregion

@onready var ui_darts_confirm_start = $OuterMargins/DartsConfirmStart


func _ready():
	ui_darts_confirm_start.visible = false
	
	
	
	#region : Player 1 dart initialization
	# Store the default dart colors and apply them to the color pickers and the custom colors array.
	p1_default_dart_colors["flight main"] = p1_dart.flight_main_color
	p1_default_dart_colors["flight secondary"] = p1_dart.flight_secondary_color
	p1_default_dart_colors["shaft"] = p1_dart.shaft_color
	p1_default_dart_colors["barrel"] = p1_dart.barrel_color
	p1_default_dart_colors["tip"] = p1_dart.tip_color
	
	p1_custom_dart_colors["flight main"] = p1_default_dart_colors["flight main"]
	p1_custom_dart_colors["flight secondary"] = p1_default_dart_colors["flight secondary"]
	p1_custom_dart_colors["shaft"] = p1_default_dart_colors["shaft"]
	p1_custom_dart_colors["barrel"] = p1_default_dart_colors["barrel"]
	p1_custom_dart_colors["tip"] = p1_default_dart_colors["tip"]
	
	p1_button_refs[4].color = p1_default_dart_colors["flight main"]
	p1_button_refs[5].color = p1_default_dart_colors["flight secondary"]
	p1_button_refs[6].color = p1_default_dart_colors["shaft"]
	p1_button_refs[7].color = p1_default_dart_colors["barrel"]
	p1_button_refs[8].color = p1_default_dart_colors["tip"]
	
	match p1_dart.team_color:
		"BLUE":
			_on_p1_team_option_selected(0)
		"RED":
			_on_p1_team_option_selected(1)
		"BLACK":
			_on_p1_team_option_selected(2)
		"WHITE":
			_on_p1_team_option_selected(3)
		"CUSTOM":
			_on_p1_team_option_selected(4)
	#endregion
	
	##region : Player 2 dart initialization
	#p2_flight_main_color_picker.color = p2_dart.flight_main_color
	#p2_flight_secondary_color_picker.color = p2_dart.flight_secondary_color
	#p2_shaft_color_picker.color = p2_dart.shaft_color
	#p2_barrel_color_picker.color = p2_dart.barrel_color
	#p2_tip_color_picker.color = p2_dart.tip_color
	#p2_custom_flight_main_color = p2_dart.custom_flight_main_color
	#p2_custom_flight_secondary_color = p2_dart.custom_flight_secondary_color
	#
	#match p2_dart.team_color:
		#"BLUE":
			#_on_p2_team_option_selected(0)
		#"RED":
			#_on_p2_team_option_selected(1)
		#"BLACK":
			#_on_p2_team_option_selected(2)
		#"WHITE":
			#_on_p2_team_option_selected(3)
		#"CUSTOM":
			#_on_p2_team_option_selected(4)
	##endregion


func _set_line_disabled(line: HBoxContainer, toggle: bool, ready_up_mode: bool = false):
	var line_num: int = line.name.get_slice("_", 1).to_int()
	if toggle:
		# Darken the label text color, if there is a label
		if p1_label_refs[line_num]:
			_darken_label(p1_label_refs[line_num], true)
		# Disable the button, if there is one
		if p1_button_refs[line_num]:
			p1_button_refs[line_num].disabled = true
		# Mark the line as disabled, as long as we're not in ready up mode
		if !ready_up_mode:
			p1_line_states[line_num] = 0
	else:
		# Lighten the label text color, if there is a label
		if p1_label_refs[line_num]:
			_darken_label(p1_label_refs[line_num], false)
		# Enable the button, if there is one
		if p1_button_refs[line_num]:
			p1_button_refs[line_num].disabled = false
		# Mark the line as enabled
		p1_line_states[line_num] = 1
		
	#match line.name.get_slice("_", 1).to_int():
		#1: # Team Color Select
			#if toggle:
				## Darken the line color
				#_darken_label(p1_label_refs[1], true)
				## Disable the color picker
				#p1_button_refs[1].disabled = true
				## Mark the line as disabled, as long as we're not in ready up mode
				#if !ready_up_mode:
					#p1_line_states[1] = 0
			#else:
				## Lighten the line color
				#_darken_label(p1_label_refs[1], false)
				## Enable the color picker
				#p1_button_refs[1].disabled = false
				## Mark the line as enabled
				#p1_line_states[1] = 1
		#2: # Customization Header
			#if toggle:
				## Darken the line color
				#_darken_label(p1_label_refs[2], true)
				## Mark the line as disabled, as long as we're not in ready up mode
				#if !ready_up_mode:
					#p1_line_states[2] = 0
			#else:
				## Lighten the line color
				#_darken_label(p1_label_refs[2], false)
				## Mark the line as enabled
				#p1_line_states[2] = 1
		#3: # Same Flight Colors Checkbox
			#if toggle:
				## Darken the line color
				#_darken_label(p1_label_refs[3], true)
				## Disable the checkbox
				#p1_button_refs[3].disabled = true
				## Mark the line as disabled, as long as we're not in ready up mode
				#if !ready_up_mode:
					#p1_line_states[3] = 0
			#else:
				## Lighten the line color
				#_darken_label(p1_label_refs[3], false)
				## Enable the color picker
				#p1_button_refs[3].disabled = false
				## Mark the line as enabled
				#p1_line_states[3] = 1
		#4: # Main Flight Color Picker
			#if toggle:
				## Darken the line color
				#_darken_label(p1_label_refs[4], true)
				## Disable the color picker
				#p1_button_refs[4].disabled = true
				## Mark the line as disabled, as long as we're not in ready up mode
				#if !ready_up_mode:
					#p1_line_states[4] = 0
			#else:
				## Lighten the line color
				#_darken_label(p1_label_refs[4], false)
				## Enable the color picker
				#p1_button_refs[4].disabled = false
				## Mark the line as enabled
				#p1_line_states[4] = 1
		#5: # Secondary Flight Color Picker
			#if toggle:
				## Darken the line color
				#_darken_label(p1_label_refs[5], true)
				## Disable the color picker
				#p1_button_refs[5].disabled = true
				## Mark the line as disabled, as long as we're not in ready up mode
				#if !ready_up_mode:
					#p1_line_states[5] = 0
			#else:
				## Lighten the line color
				#_darken_label(p1_label_refs[5], false)
				## Enable the color picker
				#p1_button_refs[5].disabled = false
				## Mark the line as enabled
				#p1_line_states[5] = 1
		#6: # Shaft Color Picker
			#if toggle:
				## Darken the line color
				#_darken_label(p1_label_refs[6], true)
				## Disable the color picker
				#p1_button_refs[6].disabled = true
				## Mark the line as disabled, as long as we're not in ready up mode
				#if !ready_up_mode:
					#p1_line_states[6] = 0
			#else:
				## Lighten the line color
				#_darken_label(p1_label_refs[6], false)
				## Enable the color picker
				#p1_button_refs[6].disabled = false
				## Mark the line as enabled
				#p1_line_states[6] = 1
		#7: # Barrel Color Picker
			#if toggle:
				## Darken the line color
				#_darken_label(p1_label_refs[7], true)
				## Disable the color picker
				#p1_button_refs[7].disabled = true
				## Mark the line as disabled, as long as we're not in ready up mode
				#if !ready_up_mode:
					#p1_line_states[7] = 0
			#else:
				## Lighten the line color
				#_darken_label(p1_label_refs[7], false)
				## Enable the color picker
				#p1_button_refs[7].disabled = false
				## Mark the line as enabled
				#p1_line_states[7] = 1
		#8: # Tip Color Picker
			#if toggle:
				## Darken the line color
				#_darken_label(p1_label_refs[8], true)
				## Disable the color picker
				#p1_button_refs[8].disabled = true
				## Mark the line as disabled, as long as we're not in ready up mode
				#if !ready_up_mode:
					#p1_line_states[8] = 0
			#else:
				## Lighten the line color
				#_darken_label(p1_label_refs[8], false)
				## Enable the color picker
				#p1_button_refs[8].disabled = false
				## Mark the line as enabled
				#p1_line_states[8] = 1
		#9: # Reset and Done Buttons. Not a valid option
			#pass


func _darken_label(label: Label, toggle: bool):
	if toggle:
		label.add_theme_color_override("font_color", Color(0.597, 0.597, 0.597, 1.0))
	else:
		label.add_theme_color_override("font_color", Color(1.0, 1.0, 1.0, 1.0))


#region : Player 1 dart customization ui signal functions
func _on_p1_team_option_selected(index):
	match index:
		0:
			# Set the dropdown's value to the selected option
			p1_button_refs[1].select(index)
			# Set the color picker's color
			p1_button_refs[4].color = Color.BLUE
			# Set the default color to the team color
			p1_default_dart_colors["flight main"] = Color.BLUE
			# Disable the main flight color picker line
			_set_line_disabled(p1_option_lines[4], true)
		1:
			# Set the dropdown's value to the selected option
			p1_button_refs[1].select(index)
			# Set the color picker's color
			p1_button_refs[4].color = Color.RED
			# Set the default color to the team color
			p1_default_dart_colors["flight main"] = Color.RED
			# Disable the main flight color picker line
			_set_line_disabled(p1_option_lines[4], true)
		2:
			p1_button_refs[1].select(index)
			p1_button_refs[4].color = Color.BLACK
			p1_default_dart_colors["flight main"] = Color.BLACK
			_set_line_disabled(p1_option_lines[4], true)
		3:
			p1_button_refs[1].select(index)
			p1_button_refs[4].color = Color.WHITE
			p1_default_dart_colors["flight main"] = Color.WHITE
			_set_line_disabled(p1_option_lines[4], true)
		4:
			# Custom Colors
			p1_button_refs[1].select(index)
			# Enable line 4 (main flight color)
			_set_line_disabled(p1_option_lines[4], false)
			# Set the color picker's color, which should also update the dart
			p1_button_refs[4].color = p1_custom_dart_colors["flight main"]


func _on_p1_use_same_colors_toggled(toggled_on):
	if toggled_on:
		# Set the secondary flight color picker color to the main flight color
		p1_button_refs[5].color = p1_button_refs[4].color
		# Disable the secondary flight's line
		_set_line_disabled(p1_option_lines[5], true)
	else:
		# Enable the line
		_set_line_disabled(p1_option_lines[5], false)
		# Set the secondary flight's color back to the custom color
		p1_button_refs[5].color = p1_custom_dart_colors["flight secondary"]


func _on_p1_custom_main_flight_color_changed(color):
	p1_custom_dart_colors["flight main"] = color


func _on_p1_custom_secondary_flight_color_changed(color):
	p1_custom_dart_colors["flight secondary"] = color


func _on_p1_shaft_color_changed(color):
	p1_custom_dart_colors["shaft"] = color


func _on_p1_barrel_color_changed(color):
	p1_custom_dart_colors["barrel"] = color


func _on_p1_tip_color_changed(color):
	p1_custom_dart_colors["tip"] = color


func _on_p1_ready_up_button_toggled(toggled_on):
	if toggled_on:
		# Flag player 1 as ready
		p1_ready = true
		
		# Disable all menu options while flagging ready up mode as true
		for line in p1_option_lines:
			if line:
				_set_line_disabled(line, true, true)
	else:
		# Flag player 1 as not ready
		p1_ready = false
		
		# Enable all menu options according to their previous states
		var i: int = 1
		while i < p1_option_lines.size():
			if p1_line_states[i]:
				_set_line_disabled(p1_option_lines[i], false)
			i += 1
	
	if toggled_on and p2_ready:
		ui_darts_confirm_start.visible = true
	
	#p1_ready = toggled_on
	#
	#var i: int = 0
	#if p1_ready:
		## Store the "disabled" state of every menu item
		#while i < p1_prev_option_line_enabled_states.size():
			#p1_prev_option_line_enabled_states[i] = !p1_all_menu_option_refs[i].disabled
			#i += 1
		#
		#print(p1_prev_option_line_enabled_states)
		#
		## Disable all menu options
		#for menu_option in p1_all_menu_option_refs:
			#menu_option.disabled = true
		## Darken all labels
		#for label in p1_all_menu_option_labels:
			#_darken_label(label, true)
	#else:
		#while i < p1_prev_option_line_enabled_states.size():
			#p1_all_menu_option_refs[i].disabled = p1_prev_option_line_enabled_states[i]
			#i += 1
	#
	#if toggled_on and p2_ready:
		#ui_darts_confirm_start.visible = true
#endregion
#
#region : Player 2 dart customization ui signal functions
#func _on_p2_team_option_selected(index):
	#match index:
		#0:
			#p2_team_select.select(index)
			#p2_flight_color_main_label.add_theme_color_override("font_color", Color(0.597, 0.597, 0.597, 1.0))
			#p2_flight_main_color_picker.color = Color.BLUE
			#p2_flight_main_color_picker.disabled = true
		#1:
			#p2_team_select.select(index)
			#p2_flight_color_main_label.add_theme_color_override("font_color", Color(0.597, 0.597, 0.597, 1.0))
			#p2_flight_main_color_picker.color = Color.RED
			#p2_flight_main_color_picker.disabled = true
		#2:
			#p2_team_select.select(index)
			#p2_flight_color_main_label.add_theme_color_override("font_color", Color(0.597, 0.597, 0.597, 1.0))
			#p2_flight_main_color_picker.color = Color.BLACK
			#p2_flight_main_color_picker.disabled = true
		#3:
			#p2_team_select.select(index)
			#p2_flight_color_main_label.add_theme_color_override("font_color", Color(0.597, 0.597, 0.597, 1.0))
			#p2_flight_main_color_picker.color = Color.WHITE
			#p2_flight_main_color_picker.disabled = true
		#4:
			#p2_team_select.select(index)
			#p2_flight_color_main_label.add_theme_color_override("font_color", Color(1.0, 1.0, 1.0, 1.0))
			#p2_flight_main_color_picker.color = p2_custom_flight_main_color
			#p2_flight_main_color_picker.disabled = false
#
#
#func _on_p2_use_same_colors_toggled(toggled_on):
	#if toggled_on:
		#p2_flight_secondary_color_picker.color = p2_flight_main_color_picker.color
		#p2_flight_secondary_color_picker.disabled = true
		#_darken_label(p2_flight_color_secondary_label, true)
	#else:
		#p2_flight_secondary_color_picker.color = p2_custom_flight_secondary_color
		#p2_flight_secondary_color_picker.disabled = false
		#_darken_label(p2_flight_color_secondary_label, false)
#
#
#func _on_p2_custom_main_flight_color_changed(color):
	#p2_custom_flight_main_color = color
#
#
#func _on_p2_custom_secondary_flight_color_changed(color):
	#p2_custom_flight_secondary_color = color
#
#
#func _on_p2_shaft_color_changed(color):
	#p2_shaft_color_picker.color = color
#
#
#func _on_p2_barrel_color_changed(color):
	#p2_barrel_color_picker.color = color
#
#
#func _on_p2_tip_color_changed(color):
	#p2_tip_color_picker.color = color
#
#
#func _on_p2_ready_up_button_toggled(toggled_on):
	#p2_ready = toggled_on
	#
	#var i: int = 0
	#if p2_ready:
		## Store the "disabled" state of every menu item
		#while i < p2_prev_menu_item_states.size():
			#p2_prev_menu_item_states[i] = p2_all_menu_option_refs[i].disabled
			#i += 1
		#
		#i = 0
		### Disable all menu options
		##for menu_option in p2_all_menu_option_refs:
			##if !menu_option.disabled:
				##menu_option.disabled = true
		### Darken all labels
		##for label in p2_all_menu_option_labels:
			##darken_label(label, true)
	#else:
		#while i < p2_prev_menu_item_states.size():
			#p2_all_menu_option_refs[i].disabled = p2_prev_menu_item_states[i]
			### Only lighten the flight labels only if they were previously enabled
			##darken_label(p2_all_menu_option_labels[i], p2_prev_menu_item_states[i])
			#i += 1
	#
	#if toggled_on and p1_ready:
		#ui_darts_confirm_start.visible = true
#endregion
