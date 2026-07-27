@tool
class_name PlayerStart
extends Node3D


@export_range(1, 4) var spawners: int = 1:
	set(new_amount):
		spawners = new_amount
		_on_spawners_amount_set()
@export_tool_button("Clear Spawners Array") var reset_button = clear_spawner_array

var spawner_template
var available_spawners: Array[Spawner] = []
var node_name: String = "Player %s Spawn"


func _ready():
	clear_spawner_array()
	_on_spawners_amount_set()


func _process(_delta):
	if Engine.is_editor_hint():
		pass


func _on_spawners_amount_set():
	# Get the difference between the new amount and the spawner array
	# Positive value == need to add that many spawners
	# Negative value == need to remove that many spawners
	var delta: int = spawners - available_spawners.size()
	prints(spawners,"-",available_spawners.size(),"=",delta)
	# Add spawners
	if delta > 0:
		var i = delta
		while i > 0:
			available_spawners.append(Spawner.new())
			available_spawners[available_spawners.size() - 1].name = node_name % available_spawners.size()
			add_child(available_spawners[available_spawners.size() - 1])
			available_spawners[available_spawners.size() - 1].owner = get_tree().edited_scene_root
			i -= 1
	# Remove spawners
	elif delta < 0:
		var i = delta
		while i < 0:
			available_spawners[available_spawners.size() - 1].queue_free()
			available_spawners.remove_at(available_spawners.size() - 1)
			i += 1
	# Space out the spawners
	space_out_spawners()
	
	print(available_spawners)


func space_out_spawners():
	var i: int
	while i < available_spawners.size():
		match available_spawners.size():
			1:
				available_spawners[i].position.x = 0
			2:
				available_spawners[i].position.x = 0.5 - i
			3:
				available_spawners[i].position.x = 1 - i
			4:
				available_spawners[i].position.x = 1.5 - i
		i += 1


func clear_spawner_array():
	prints("Before:", available_spawners)
	
	for spawner in available_spawners:
		available_spawners[available_spawners.find(spawner)].queue_free()
	available_spawners.clear()
	
	prints("After:", available_spawners)
