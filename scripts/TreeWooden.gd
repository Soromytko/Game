class_name TreeWooden
extends Node

var wood_scene = preload("res://Wood.tscn")
var foliage_scene = preload("res://Foliage.tscn")

var rng = RandomNumberGenerator.new()

func destroy():
	
	for i in 3:
		var wood = wood_scene.instance()
		get_node("/root/Spatial").add_child(wood)
		wood.transform.origin.x = self.transform.origin.x
		wood.transform.origin.y = i * 5
		wood.transform.origin.z = self.transform.origin.z
	
	rng.seed = hash("Godot")
	rng.state = 100
	
	for i in 7:
		var foliage = foliage_scene.instance()
		get_node("/root/Spatial").add_child(foliage)
		foliage.transform.origin.x = self.transform.origin.x + rng.randf_range(-5, 5)
		foliage.transform.origin.y = rng.randf_range(10, 20)
		foliage.transform.origin.z = self.transform.origin.z + rng.randf_range(-5, 5)
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
