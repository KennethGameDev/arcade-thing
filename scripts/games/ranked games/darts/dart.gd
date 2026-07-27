@tool
class_name Dart
extends Node3D

#region : Mesh vars
@export var tip_mesh: MeshInstance3D
@export var barrel_mesh: MeshInstance3D
@export var shaft_mesh: MeshInstance3D
@export var flight_mesh_main: MeshInstance3D
@export var flight_mesh_secondary: MeshInstance3D
#endregion
#region : Color customization vars
@export_category("Color Customization")
## The main flight will be locked to the dart's team color.
@export_enum("BLUE", "RED", "BLACK", "WHITE", "CUSTOM") var team_color = "BLUE":
	set(new_value):
		team_color = new_value
		notify_property_list_changed()
## The second flight color will be matched to the main color.
@export var both_same_color: bool = false:
	set(new_value):
		both_same_color = new_value
		_on_set_flight_color()
		notify_property_list_changed()
## The main flight color.
@export var flight_main_color: Color = Color(0.337, 0.337, 0.337, 1.0):
	set(new_color):
		if team_color == "CUSTOM":
			custom_flight_main_color = new_color
			flight_main_color = custom_flight_main_color
		else:
			flight_main_color = new_color
		_on_set_flight_color()
		notify_property_list_changed()
## The secondary flight color.
@export var flight_secondary_color: Color = Color(0.337, 0.337, 0.337, 1.0):
	set(new_color):
		if !both_same_color:
			custom_flight_secondary_color = new_color
			flight_secondary_color = custom_flight_secondary_color
		else:
			flight_secondary_color = new_color
		_on_set_flight_color()
		notify_property_list_changed()
## The shaft color.
@export var shaft_color: Color = Color(0.537, 0.537, 0.537, 1.0):
	set(new_color):
		shaft_color = new_color
		_on_set_shaft_color()
		notify_property_list_changed()
## The barrel color.
@export var barrel_color: Color = Color(0.973, 0.292, 0.109, 1.0):
	set(new_color):
		barrel_color = new_color
		_on_set_barrel_color()
		notify_property_list_changed()
## The tip color
@export var tip_color: Color = Color(0.25, 0.25, 0.25, 1.0):
	set(new_color):
		tip_color = new_color
		_on_set_tip_color()
		notify_property_list_changed()
@export_storage var custom_flight_main_color: Color = Color(0.337, 0.337, 0.337, 1.0):
	set(new_main_color):
		custom_flight_main_color = new_main_color
@export_storage var custom_flight_secondary_color: Color = Color(0.337, 0.337, 0.337, 1.0):
	set(new_secondary_color):
		custom_flight_secondary_color = new_secondary_color
var tip_material: StandardMaterial3D
var barrel_material: StandardMaterial3D
var shaft_material: StandardMaterial3D
var flight_material_main: StandardMaterial3D
var flight_material_secondary: StandardMaterial3D
#endregion


func _ready():
	match team_color:
		"BLUE":
			flight_main_color = Color.BLUE
		"RED":
			flight_main_color = Color.RED
		"BLACK":
			flight_main_color = Color.BLACK
		"WHITE":
			flight_main_color = Color.WHITE
		"CUSTOM":
			flight_main_color = custom_flight_main_color


func _on_set_tip_color():
	tip_material = StandardMaterial3D.new()
	tip_material.albedo_color = tip_color
	if tip_mesh:
		tip_material.transparency = tip_mesh.mesh.surface_get_material(0).transparency
		tip_material.roughness = tip_mesh.mesh.surface_get_material(0).roughness
		tip_mesh.set_surface_override_material(0, tip_material)


func _on_set_barrel_color():
	barrel_material = StandardMaterial3D.new()
	barrel_material.albedo_color = barrel_color
	if barrel_mesh:
		barrel_material.transparency = barrel_mesh.mesh.surface_get_material(0).transparency
		barrel_material.roughness = barrel_mesh.mesh.surface_get_material(0).roughness
		barrel_mesh.set_surface_override_material(0, barrel_material)


func _on_set_shaft_color():
	shaft_material = StandardMaterial3D.new()
	shaft_material.albedo_color = shaft_color
	if shaft_mesh:
		shaft_material.transparency = shaft_mesh.mesh.surface_get_material(0).transparency
		shaft_material.metallic = shaft_mesh.mesh.surface_get_material(0).metallic
		shaft_material.roughness = shaft_mesh.mesh.surface_get_material(0).roughness
		shaft_mesh.set_surface_override_material(0, shaft_material)


func _on_set_flight_color():
	flight_material_main = StandardMaterial3D.new()
	flight_material_secondary = StandardMaterial3D.new()
	
	# Main Flight color logic:
	if team_color == "CUSTOM":
		flight_material_main.albedo_color = custom_flight_main_color
	else:
		flight_material_main.albedo_color = flight_main_color
	if flight_mesh_main:
		flight_material_main.transparency = flight_mesh_main.mesh.surface_get_material(0).transparency
		flight_material_main.roughness = flight_mesh_main.mesh.surface_get_material(0).roughness
		flight_mesh_main.set_surface_override_material(0, flight_material_main)
	
	# Secondary Flight color logic:
	if both_same_color:
		flight_material_secondary.albedo_color = flight_main_color
	else:
		flight_material_secondary.albedo_color = custom_flight_secondary_color
	if flight_mesh_secondary:
		flight_material_secondary.transparency = flight_mesh_secondary.mesh.surface_get_material(0).transparency
		flight_material_secondary.roughness = flight_mesh_secondary.mesh.surface_get_material(0).roughness
		flight_mesh_secondary.set_surface_override_material(0, flight_material_secondary)


func _validate_property(property):
	if property.name == "flight_main_color":
		# Updates the main flight color on team color change
		match team_color:
			"BLUE":
				flight_main_color = Color.BLUE
			"RED":
				flight_main_color = Color.RED
			"BLACK":
				flight_main_color = Color.BLACK
			"WHITE":
				flight_main_color = Color.WHITE
			"CUSTOM":
				flight_main_color = custom_flight_main_color
		# Disables the main flight color picker when a non-custom color is selected
		if team_color != "CUSTOM":
			property.usage |= PROPERTY_USAGE_READ_ONLY
	
	# Disable the secondary flight color picker when "both same color" is selected
	if property.name == "flight_secondary_color":
		if both_same_color:
			flight_secondary_color = flight_main_color
			property.usage |= PROPERTY_USAGE_READ_ONLY
		else:
			flight_secondary_color = custom_flight_secondary_color


#region : UI signal functions
func _on_team_option_selected(index):
	match index:
		0:
			team_color = "BLUE"
			flight_main_color = Color.BLUE
		1:
			team_color = "RED"
			flight_main_color = Color.RED
		2:
			team_color = "BLACK"
			flight_main_color = Color.BLACK
		3:
			team_color = "WHITE"
			flight_main_color = Color.WHITE
		4:
			team_color = "CUSTOM"
			flight_main_color = custom_flight_main_color


func _on_both_same_color_toggle(toggled_on):
	both_same_color = toggled_on
	_on_set_flight_color()


func _on_flight_main_ui_color_changed(color):
	custom_flight_main_color = color
	_on_set_flight_color()


func _on_flight_secondary_ui_color_changed(color):
	custom_flight_secondary_color = color
	_on_set_flight_color()


func _on_shaft_ui_color_changed(color):
	shaft_color = color
	_on_set_shaft_color()


func _on_barrel_ui_color_changed(color):
	barrel_color = color
	_on_set_barrel_color()


func _on_tip_ui_color_changed(color):
	tip_color = color
	_on_set_tip_color()
#endregion
