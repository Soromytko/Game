extends Spatial

var tree_scene = preload("res://Prefabs/Tree.tscn")
export var tree_density = 3

var trees = []
func _ready():
	
	$Terrain.generate(0)
	var vertices = $Terrain.vertx
	
	var rng = RandomNumberGenerator.new()
	rng.seed = hash("Godot")
	rng.state = 100
	for i in $Terrain.width * $Terrain.width / 10000 * tree_density:
		var tree = tree_scene.instance()
		get_node("/root/Spatial").call_deferred("add_child", tree)
		var v = rng.randi_range(0, vertices.size() - 1)
#		tree.transform.origin.x = x
		tree.transform.origin = vertices[v]
#		tree.transform.origin.z = z
#		print(tree.get_parent())
		trees.append(tree)
		
		
	var v = rng.randi_range(0, vertices.size() - 1)
	get_node("/root/Spatial/Player").global_transform.origin = vertices[v]
