@tool
extends Node3D
class_name Plant3D

@export var generate_plant : bool = false

#@export var generate_random : bool = false : set = random_plant
@export var symmetry : bool = false

@export_group("Plant Generation")
# this stuff could be sectioned and saved into a custom 'PlantDNA' resource class later.
@export var iterations : int = 2
@export var line_length : float = 0.1
@export var line_width : float = 0.2
@export var angle : float = 25.7
@export var l_system_string : String = ""
@export var axiom : String = "F"
@export var rules : String = "F=F[+F+F+F][-F-F-F]"
# rarely used..
@export var constants : String
@export var output_string : String

@export_group("Plant Properties")
@export_range(0,100) var foliage_percentage : int = 100



@export_group("Resources")
### list of materials for each element goes here in an array ! TODO
@export var material : StandardMaterial3D

var _stack = []

func _process(delta):
	if generate_plant:
		for child in get_children():
			child.queue_free()
		generate()
		generate_plant = false




var _angle = 0.0
func generate():
	line_width = 0.2
	var system_commands = generate_string()
	var _direction = Vector3(0, line_length, 0)
	var _pos = Vector3.ZERO
	var bush_size = 1
	for command in system_commands:
		match command["cmd"]:
			"F":
				var next_pos = _pos + _direction
				draw_line(_pos, next_pos, line_width)
				_pos = next_pos
			"B":
				var dice = randi_range(0,100)
				if dice < foliage_percentage:
					var bush = Bush3D.new()
					bush.many = 12
					bush.position = _pos
					bush.material = load("res://addons/bush_3d/materials/shrub/foliage.tres").duplicate()

					add_child(bush,true)
					bush.owner = self
			"+":
				var next_pos = _pos + _direction
				var x_rot = deg_to_rad(angle)
				_direction += Vector3(x_rot, line_length ,0)
				draw_line(_pos, next_pos, line_width)
				_pos = next_pos
				
				draw_line(_pos, next_pos, line_width)
				_pos = next_pos
			"-":
				var next_pos = _pos + _direction
				var x_rot = deg_to_rad(angle)
				_direction += Vector3(-x_rot, line_length ,0)
				draw_line(_pos, next_pos, line_width)
				_pos = next_pos
			"/":
				var next_pos = _pos + _direction
				var z_rot = deg_to_rad(angle)
				_direction += Vector3(0 ,line_length ,z_rot)
				draw_line(_pos, next_pos, line_width)
				_pos = next_pos
			"\\":
				var next_pos = _pos + _direction
				var z_rot = deg_to_rad(angle)
				_direction += Vector3(0, line_length ,-z_rot)
				draw_line(_pos, next_pos, line_width)
				_pos = next_pos

			"[":
				_stack.append({"pos": _pos, "direction": _direction})

			"]":
				line_width -= line_width/100
				
				bush_size += 0.01
				#line_length -= line_length/1000
				var prev_state = _stack.pop_back()
				_pos = prev_state["pos"]
				_direction = prev_state["direction"]
				var next_pos = _pos + _direction
				draw_line(_pos, next_pos, line_width)
				_pos = next_pos
	#get_child(0).queue_free()
	#print(get_children())

func draw_line(start: Vector3, end: Vector3, width: float) -> void:
	var line = Line3D.new()
	line.point_a = start
	line.point_b = end
	line.width = line_width
	line.segments = 6
	line.material = material
	add_child(line,true)
	line.owner = self


func parse_rules(rules_str: String) -> Dictionary:
	var _rules = {}
	var rule_pairs = rules_str.split(",")
	for pair in rule_pairs:
		var parts = pair.split("=")
		if parts.size() == 2:
			_rules[parts[0].strip_edges()] = parts[1].strip_edges()
	return _rules


func generate_string() -> Array:
	var rules_string = parse_rules(rules)
	var current_string = axiom
	_stack.clear()

	for i in range(iterations):
		var new_string = ""
		for char in current_string:
			if char in rules_string:
				new_string += rules_string[char]
			else:
				new_string += char
		current_string = new_string

	var commands = []
	for char in current_string:
		commands.append({"cmd": char})

	output_string = ""
	for item in commands:
		output_string += item["cmd"]
	
	print("DNA SEED: ", rules)
	print("\n_______________________________________\nFull DNA after %s iterations:\n" % int(iterations))
	print(output_string)
	print("\n_______________________________________\n")
	return commands
