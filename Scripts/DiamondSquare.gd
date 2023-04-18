class_name DiamondSquare

var _roughness = 0.1
var _seed = 0
var _max = -10000
var _min = 10000

func generate(size : Vector2, roughness : float, seed_value : int):
	_roughness = roughness
	_seed = seed_value
	
	var result = []
	result.resize(size.x)
	for x in size.x:
		result[x] = []
		result[x].resize(size.y)
		
	var rng = RandomNumberGenerator.new()
#	rng.seed = hash("DSsd")
	rng.seed = _seed
	result = _initialize(result, rng)
	result = _iterate(result, 0, rng)
	result = _subdivide(result)
	
	for i in range(0, result.size()):
		for j in range(result[i].size(), result.size()):
			if result[i][j] < 0: print(result[i][j])
			result[i][j] = (result[i][j]) * (_max - _min) + _min
#			result[i][j] *= 20
	result = _subdivide(result)
	
			
	return result
	
	
func _initialize(data, rng : RandomNumberGenerator):
	var random_value = rng.randf_range(-2, 2)
	
	var x_max = data.size() - 1
	var y_max = data[0].size() - 1
	
	data[0][0] = rng.randf_range(-2, 2)
	data[x_max][0] = rng.randf_range(-2, 2)
	data[0][y_max] = rng.randf_range(-2, 2)
	data[x_max][y_max] = rng.randf_range(-2, 2)
	
	return data
	

func _iterate(data, depth : int, rng : RandomNumberGenerator):
	var denominator = pow(2, depth)
	var size = Vector2((data.size() - 1) / denominator, (data[0].size() - 1) / denominator)
	size.x = size.x as int
	size.y = size.y as int
	var half = size / 2
	half.x = half.x as int
	half.y = half.y as int
	
	if half.x == 0 && half.y == 0:
		return data
	
	if half.x == 0: half.x = 1
	if half.y == 0: half.y = 1
	
	var d = 1
	
#	print("diamond")
	for x in range(half.x, data.size(), size.x):
		for y in range(half.y, data[x].size(), size.y):
#			print("x = ", x, " y = ", y)
			var deviation = rng.randf_range(-d, d) * size.length() * _roughness
			_diamond(data, x, y, half, deviation)
			if data[x][y] < _min: _min = data[x][y]
			if data[x][y] > _max: _max = data[x][y]
			
			
#	print("square")
	for x in range(0, data.size(), half.x):
#		print("x = ", x, " half.x = ", half.x, " size.x = ", size.x)
		for y in range((x + half.x as int) % (size.x as int), data[x].size(), size.y):
#			print("x = ", x, " y = ", y)
			var deviation = rng.randf_range(-d, d) * size.length() * _roughness
			_square(data, x, y, half, deviation)
			if data[x][y] < _min: _min = data[x][y]
			if data[x][y] > _max: _max = data[x][y]
			
	return _iterate(data, depth + 1, rng)
	
	
func _diamond(data, x : int, y : int, size, deviation : float):
	var v0 = data[x - size.x][y - size.y]
	var v1 = data[x - size.x][y + size.y]
	var v2 = data[x + size.x][y + size.y]
	var v3 = data[x + size.x][y - size.y]
	
	data[x][y] = (v0 + v1 + v2 + v3) / 4.0 + deviation
#	data[x][y] = (v0 + v1 + v2 + v3) / 4.0
	
	
func _square(data, x : int, y : int, size : Vector2, deviation : float):
	var v0 = 0 if x - size.x < 0 else data[x - size.x][y]
	var v1 = 0 if x + size.x >= data.size() else data[x + size.x][y]
	var v2 = 0 if y - size.y < 0 else data[x][y - size.y]
	var v3 = 0 if y + size.y >= data[x].size() else data[x][y + size.y]
	
	data[x][y] = (v0 + v1 + v2 + v3) / 4.0 + deviation
#	data[x][y] = (v0 + v1 + v2 + v3) / 4.0
	
	
func _subdivide(data):
	for i in data.size():
		for j in data[i].size():
			var a = 0 if i - 1 < 0 || j - 1 < 0 else data[i - 1][j - 1]
			var b = 0 if i - 1 < 0 || j + 1 >= data[i].size() else data[i - 1][j + 1]
			var c = 0 if i + 1 >= data.size() || j + 1 >= data[i].size() else data[i + 1][j + 1]
			var d = 0 if i + 1 >= data.size() || j - 1 < 0 else data[i + 1][j - 1]
			
			var e = 0 if i - 1 < 0 else data[i - 1][j]
			var f = 0 if j - 1 < 0 else data[i][j - 1]
			var g = 0 if i + 1 >= data.size() else data[i + 1][j]
			var h = 0 if j + 1 >= data[i].size() else data[i][j + 1]
			
			data[i][j] = (a + b + c + d + e + f + g + h) / 8.0
	
	return data
	
	
