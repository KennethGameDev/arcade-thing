@tool
class_name Spawner
extends Node3D


var spawner_node: Node3D
var body_mesh: MeshInstance3D
var body_mesh_mat: StandardMaterial3D
var pointer_mesh: MeshInstance3D
var pointer_mesh_mat: StandardMaterial3D


func _init(p_spawner_node = spawner_node, p_body_mesh = MeshInstance3D.new(), p_body_mesh_mat = StandardMaterial3D.new(), p_pointer_mesh = MeshInstance3D.new(), p_pointer_mesh_mat = StandardMaterial3D.new()):
	spawner_node = p_spawner_node
	body_mesh = p_body_mesh
	body_mesh_mat = p_body_mesh_mat
	pointer_mesh = p_pointer_mesh
	pointer_mesh_mat = p_pointer_mesh_mat
	
	spawner_node = Node3D.new()
	
	body_mesh.mesh = CapsuleMesh.new()
	body_mesh.set_surface_override_material(0, body_mesh_mat)
	body_mesh.position = Vector3(0, 1, 0)
	
	body_mesh_mat.emission_enabled = true
	body_mesh_mat.emission_energy_multiplier = 0.5
	body_mesh_mat.emission = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1))
	print(body_mesh_mat.emission)
	
	add_child(body_mesh)
	
	pointer_mesh_mat.albedo_color = Color.DARK_RED
	
	pointer_mesh.mesh = CylinderMesh.new()
	pointer_mesh.mesh.top_radius = 0
	pointer_mesh.mesh.bottom_radius = 0.25
	pointer_mesh.mesh.height = 0.75
	pointer_mesh.set_surface_override_material(0, pointer_mesh_mat)
	pointer_mesh.position = Vector3(0, 1, -0.79)
	pointer_mesh.rotation = Vector3(-PI/2, 0, 0)
	
	add_child(pointer_mesh)
