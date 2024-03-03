@tool
extends MultiMeshInstance3D
class_name PlantMesh

@export var mesh_amount = 0 : set = set_mesh_amount

var offset : Vector3 = Vector3(0.0, 0.0, 0.0)
var distance : Transform3D = Transform3D(Basis(), offset)

signal amount_changed

func _ready():
	instance_meshes(mesh_amount)


func set_mesh_amount(value: int) -> void:
	mesh_amount = value
	multimesh.instance_count = value
	instance_meshes(mesh_amount)
	emit_signal("amount_changed")

func instance_meshes(amount: int) -> void:
	var mesh_height = multimesh.mesh.get_aabb().size.y
	offset.y = 0.0  # Reset the offset
	var r = randf_range(0.0,0.5)
	var wobble = Vector3(r,r,r)
	var bas = Basis()
	for i in range(amount):
		multimesh.set_instance_transform(i, distance)
		
		#bas.y.y += amount # this scales it in the y
		#bas.z.z += amount # this scales it in the z
		offset.y += (mesh_height*amount)/amount  # Update offset.y based on mesh height
		distance = Transform3D(bas, offset)
		
