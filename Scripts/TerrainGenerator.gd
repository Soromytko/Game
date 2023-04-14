extends MeshInstance
tool



func build_mesh(vertices, indices):
	
	var normals = []
	normals.resize(vertices.size())
	for i in normals.size():
		normals[i] = Vector3(0, 1, 0)
	
	var mesh_data = []
	mesh_data.resize(ArrayMesh.ARRAY_MAX)
	mesh_data[ArrayMesh.ARRAY_VERTEX] = PoolVector3Array(vertices)
	mesh_data[ArrayMesh.ARRAY_INDEX] = PoolIntArray(indices)
	mesh_data[ArrayMesh.ARRAY_NORMAL] = PoolVector3Array(normals);
	
	mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, mesh_data)
	
	print("mesh is built")



func _generate_heightmap(width : int, depth : int):
	width += 1
	depth += 1
	var result = []
	result.resize(width * depth)
	
	var rng = RandomNumberGenerator.new()
	
	rng.seed = hash(OS.get_datetime())
		
	for x in width:
		for z in depth:
			var height = rng.randf_range(0, 1)
			result[x * width + z] = Vector3(x, height, z)
		
	return result
	
	
func _generate():
	var width = 10
	var depth = 10
	var vertices = _generate_heightmap(width, depth)
	
	var indices = []
	indices.resize(width * depth * 6)
	
	var vert : int = 0
	var ind : int = 0
	for x in width:
		for z in depth:
			indices[ind + 0] = vert + 0
			indices[ind + 1] = vert + depth + 1
			indices[ind + 2] = vert + 1
			indices[ind + 3] = vert + depth + 1
			indices[ind + 4] = vert + depth + 2
			indices[ind + 5] = vert + 1
		
			vert += 1
			ind += 6
		vert += 1
			
	build_mesh(vertices, indices)


func _process(delta):
	if Engine.is_editor_hint():
		if Input.is_key_pressed(KEY_ALT):
			_generate()
			
		
		
