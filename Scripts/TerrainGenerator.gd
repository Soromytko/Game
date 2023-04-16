extends Spatial
tool

export(bool) var generate setget generate
export var width : int = 16
export var depth : int = 16
export var smoothing : float = 1

var mesh_instance

func generate(__):
	mesh_instance = $MeshInstance
	_generate()


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
	
	var array_mesh = ArrayMesh.new()
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, mesh_data)
	
	var surface_tool = SurfaceTool.new()
	surface_tool.create_from(array_mesh, 0)
	surface_tool.generate_normals()
	
	mesh_instance.mesh = surface_tool.commit()
	
	print("mesh is built")


func _get_1d_from_2d(i, j, i_size, j_size):
	return -1 if i >= i_size || j >= j_size  else i * i_size + j


func _squre(vertices, x, z, size):
	var rng = RandomNumberGenerator.new()
	rng.speed = hash(OS.get_datetime())
	
	var v0 = rng.randf_range(-2, 2)
	var v1 = rng.randf_range(-2, 2)
	var v2 = rng.randf_range(-2, 2)
	var v3 = rng.randf_range(-2, 2)
	
	var x_s = vertices.size() / 2
	var z_s = vertices.size() / 2
	
	vertices[_get_1d_from_2d(x - size, z, x_s, z_s)] = v0
	vertices[_get_1d_from_2d(x + size, z, x_s, z_s)] = v1
	vertices[_get_1d_from_2d(x, z - size, x_s, z_s)] = v2
	vertices[_get_1d_from_2d(x, z + size, x_s, z_s)] = v3
	
	
	
func _diamond(vertices, x, z, size):
	var rng = RandomNumberGenerator.new()
	rng.speed = hash(OS.get_datetime())
	
	var x_s = vertices.size() / 2
	var z_s = vertices.size() / 2
	
	var v0 = vertices[_get_1d_from_2d(x - size, z - size, x_s, z_s)]
	var v1 = vertices[_get_1d_from_2d(x + size, z - size, x_s, z_s)]
	var v2 = vertices[_get_1d_from_2d(x - size, z + size, x_s, z_s)]
	var v3 = vertices[_get_1d_from_2d(x + size, z + size, x_s, z_s)]
	
	
	var o = (v0 + v1 + v2 + v3) / 4.0 + rng.randf_range(-2, 2)
	
	vertices[_get_1d_from_2d(x, y, x_s, z_s)] = 0
	
	
func _core(vertices, x, z, x_size, z_size):
	
	_squre(vertices, x, z, x_size)
	_diamond(vertices, x, z, x_size)
	
	var x_new_size = x_size / 2
	var z_new_size = z_size / 2
	
	if x_new_size
	
	
	_core(vertices, x - x_new_size / 2, z - z_new_size, x_new_size, z_new_size)
	_core(vertices, x + x_new_size / 2, z - z_new_size, x_new_size, z_new_size)
	_core(vertices, x - x_new_size / 2, z + z_new_size, x_new_size, z_new_size)
	_core(vertices, x + x_new_size / 2, z + z_new_size, x_new_size, z_new_size)
	


func _start_diamond_square(vertices, x_size, y_size):
	var rng = RandomNumberGenerator.new()
	rng.speed = hash(OS.get_datetime())
	
	var v0 = rng.randf_range(-2, 2)
	var v1 = rng.randf_range(-2, 2)
	var v2 = rng.randf_range(-2, 2)
	var v3 = rng.randf_range(-2, 2)
	
	var x_s = vertices.size() / 2
	var z_s = vertices.size() / 2
	
	vertices[_get_1d_from_2d(x - size, z - size, x_s, z_s)] = v0
	vertices[_get_1d_from_2d(x + size, z - size, x_s, z_s)] = v1
	vertices[_get_1d_from_2d(x - size, z + size, x_s, z_s)] = v2
	vertices[_get_1d_from_2d(x + size, z + size, x_s, z_s)] = v3
	
	
	
	
	pass
	

func _squre(vertices, x, z, x_size, z_size):
	var rng = RandomNumberGenerator.new()
	rng.speed = hash(OS.get_datetime())
	
	var oo = rng.randf_range(-2, 2)
	var xo = rng.randf_range(-2, 2)
	var oz = rng.randf_range(-2, 2)
	var xz = rng.randf_range(-2, 2)
	
	var o = (oo + xo + oz + xz) / 4.0 + rng.randf_range(-2, 2)
	
	
	vertices[x * width + z].y = rng.randf_range(-2, 2)
	vertices[(x + x_size) * width + z].y = rng.randf_range(-2, 2)
	vertices[x * width + z + z_size].y = rng.randf_range(-2, 2)
	vertices[(x + x_size) * width + z + z_size].y = rng.randf_range(-2, 2)
	

func _generate_heightmap(x_count : int, z_count : int, step : float):
	x_count += 1
	z_count += 1
	var result = []
	result.resize(x_count * z_count)
	
	var rng = RandomNumberGenerator.new()
	
	rng.seed = hash(OS.get_datetime())
		
#	for x in x_count:
#		for z in z_count:
#			var height = rng.randf_range(0, 1)
##			height = 0
#			result[x * x_count + z] = Vector3(x * step, height, z * step)

			
	return result
	
	
func _generate():
	var width_s = width * smoothing
	var depth_s = depth * smoothing
	
	var vertices = _generate_heightmap(width_s, depth_s, 1.0 / smoothing)
	
	var indices = []
	indices.resize(width_s * depth_s * 6)
	
	var vert : int = 0
	var ind : int = 0
	for x in width_s:
		for z in depth_s:
			indices[ind + 0] = vert + 0
			indices[ind + 1] = vert + depth_s + 1
			indices[ind + 2] = vert + 1
			indices[ind + 3] = vert + depth_s + 1
			indices[ind + 4] = vert + depth_s + 2
			indices[ind + 5] = vert + 1
		
			vert += 1
			ind += 6
		vert += 1
			
	build_mesh(vertices, indices)


#func _process(delta):
#	if Engine.is_editor_hint():
#		if Input.is_key_pressed(KEY_ALT):
#			_generate()
			
		
		
