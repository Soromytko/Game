class_name Inventory
extends Node

onready var hand = get_parent().get_node("Hand")
onready var axe = get_node("/root/Spatial/Axe2")
var tree_scene = preload("res://scenes/prefabs/Tree.tscn")

var trees = []
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.seed = hash("Godot")
	rng.state = 100
	for i in 5:
		var tree = tree_scene.instance()
		get_node("/root/Spatial").call_deferred("add_child", tree)
		tree.transform.origin.x = rng.randf_range(-50, 50)
		tree.transform.origin.y = 0
		tree.transform.origin.z = rng.randf_range(-50, 50)
#		print(tree.get_parent())
		trees.append(tree)
		
		
func set_parent2(parent, child):
	child.get_parent().remove_child(child)
	parent.add_child(child)
	

	
func add_item(item):
	item.get_node("CollisionShape").disabled = true
	item.mode = RigidBody.MODE_STATIC
	TransformExtension.reparent(item, hand)
	item.rotation_degrees = Vector3.ZERO
#	item.b = true
	item.transform.origin = Vector3.ZERO
#	item.global_transform.origin = hand.global_transform.origin


