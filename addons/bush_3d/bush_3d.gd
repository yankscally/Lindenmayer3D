@tool
extends MultiMeshInstance3D
class_name Bush3D

@export var planted = false
@export_range(0,50) var many = 10 : set = generate_bush
var material : StandardMaterial3D


func _ready():
	multimesh = MultiMesh.new()
	multimesh.mesh = RibbonTrailMesh.new()
	generate_bush(many)

func generate_bush(instances):
	many = instances
	multimesh.instance_count = 0
	multimesh.transform_format = MultiMesh.TRANSFORM_3D

	var xaxis = Vector3(1,0,0)
	var yaxis = Vector3(0,1,0)
	var zaxis = Vector3(0,0,1)
	var rotation_amount = 0.1
	
	multimesh.instance_count = many
	for i in many:
		var rx = randf_range(-2,2)
		var ry = randf_range(-2,2)
		var rz = randf_range(-2,2)
		randomize()
		var t = Transform3D()
		rotation_amount += 0.25
		t.basis = Basis(xaxis,rx) * t.basis
		t.basis = Basis(yaxis,ry) * t.basis
		t.basis = Basis(zaxis,rz) * t.basis
		
		if planted:
			t.origin.y = multimesh.mesh.size/2
		
		multimesh.set_instance_transform(i,t)
	
	multimesh.mesh.surface_set_material(0,material)

