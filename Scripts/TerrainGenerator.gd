	
extends Spatial
tool
export(bool) var generate_mesh setget generate_mesh

onready var mesh_instance = $MeshInstance

func generate_mesh(__):
	mesh_instance = $MeshInstance
	_generate()

#
#func build_mesh(vertices, indices):
#
#	var normals = []
#	normals.resize(vertices.size())
#	for i in normals.size():
#		normals[i] = Vector3(0, 1, 0)
#
#	var mesh_data = []
#	mesh_data.resize(ArrayMesh.ARRAY_MAX)
#	mesh_data[ArrayMesh.ARRAY_VERTEX] = PoolVector3Array(vertices)
#	mesh_data[ArrayMesh.ARRAY_INDEX] = PoolIntArray(indices)
#	mesh_data[ArrayMesh.ARRAY_NORMAL] = PoolVector3Array(normals);
#
#	mesh = ArrayMesh.new()
#	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, mesh_data)
#
#	print("mesh is built")
#
#
#
#func _generate_heightmap(width : int, depth : int):
#	width += 1
#	depth += 1
#	var result = []
#	result.resize(width * depth)
#
#	var rng = RandomNumberGenerator.new()
#
#	rng.seed = hash(OS.get_datetime())
#
#	for x in width:
#		for z in depth:
#			var height = rng.randf_range(0, 1)
#			result[x * width + z] = Vector3(x, height, z)
#
#	return result
#
#
func _generate():
	print("Generating mesh...")
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(10, 10)
	plane_mesh.subdivide_width = 3
	plane_mesh.subdivide_depth = 3
	
	var surface_tool = SurfaceTool.new()
	surface_tool.create_from(plane_mesh)
	var data = surface_tool.commit_to_arrays()
	
	mesh_instance.mesh = plane_mesh

